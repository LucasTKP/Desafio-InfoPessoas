import 'package:flutter/cupertino.dart';
import 'package:infopessoas/data/repositories/person/person_repository.dart';
import 'package:infopessoas/domain/enums/state_screen.dart';
import 'package:infopessoas/domain/models/people/person_model.dart';
import 'dart:developer' as developer;

class ListFavoritePersonsViewmodel extends ChangeNotifier {
  final PersonRepository personRepository;

  ListFavoritePersonsViewmodel({required this.personRepository}) {
    fetchFavoritePersons();
  }

  List<PersonModel> favoritePersons = [];
  StateScreen stateScreen = StateScreen.initial;

  Future<void> removeFromFavorites(String personId) async {
    try {
      await personRepository.deletePersonLocal(personId);
      favoritePersons.removeWhere((person) => person.id == personId);
      notifyListeners();
    } catch (e) {
      developer.log(e.toString());
      rethrow;
    }
  }

  Future<void> fetchFavoritePersons() async {
    _setStateScreen(StateScreen.loading);
    try {
      favoritePersons = await personRepository.getAllFavoritePersons();
      _setStateScreen(StateScreen.loaded);
    } catch (e) {
      developer.log(e.toString());
      _setStateScreen(StateScreen.error);
    }
  }

  void _setStateScreen(StateScreen state) {
    stateScreen = state;
    notifyListeners();
  }
}
