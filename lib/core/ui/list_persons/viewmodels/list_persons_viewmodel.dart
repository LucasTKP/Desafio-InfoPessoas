import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:infopessoas/data/repositories/person/person_repository.dart';
import 'package:infopessoas/domain/models/people/person_model.dart';
import 'package:infopessoas/core/services/identify_error_service.dart';
import 'dart:developer' as developer;

class ListPersonsViewmodel {
  final PersonRepository personRepository;
  final TickerProvider vsync;

  ListPersonsViewmodel({required this.personRepository, required this.vsync}) {
    fetchPersons();
  }

  ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  ValueNotifier<List<PersonModel>> persons = ValueNotifier<List<PersonModel>>([]);

  late Ticker _ticker;
  Duration _lastElapsed = Duration.zero;
  static const Duration _tickInterval = Duration(seconds: 5);

  void startTicker() {
    _ticker = vsync.createTicker(_onTick);
    _ticker.start();
  }

  void _onTick(Duration elapsed) {
    if (elapsed - _lastElapsed >= _tickInterval) {
      _lastElapsed = elapsed;
      fetchPersons();
    }
  }

  Future<void> fetchPersons() async {
    if (isLoading.value) return;

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final person = await personRepository.fetchRandomPerson();
      persons.value = [...persons.value, person];
    } catch (e) {
      errorMessage.value = identifyError(error: e, message: 'Erro ao buscar pessoa.');
      developer.log('Erro ao buscar pessoa: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void dispose() {
    _ticker.dispose();
    errorMessage.dispose();
    isLoading.dispose();
    persons.dispose();
  }
}
