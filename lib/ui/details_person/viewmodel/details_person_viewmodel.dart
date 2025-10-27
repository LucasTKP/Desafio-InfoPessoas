import 'package:flutter/material.dart';
import 'package:infopessoas/data/repositories/person/person_repository.dart';
import 'package:infopessoas/domain/models/people/person_model.dart';
import 'dart:developer' as developer;

class DetailsPersonViewmodel {
  final PersonRepository personRepository;

  DetailsPersonViewmodel({required this.personRepository});

  ValueNotifier<bool> buttonFavoriteisLoading = ValueNotifier<bool>(false);
  bool isFavorite = false;

  Future<void> initialize(String idPerson) async {
    if (buttonFavoriteisLoading.value) return;

    buttonFavoriteisLoading.value = true;

    try {
      final favoritePerson = await personRepository.getPersonById(idPerson);
      isFavorite = favoritePerson != null;
    } catch (e) {
      developer.log('Erro ao verificar favorito: $e');
      rethrow;
    } finally {
      buttonFavoriteisLoading.value = false;
    }
  }

  Future<void> toggleFavorite(PersonModel person) async {
    if (buttonFavoriteisLoading.value) return;

    buttonFavoriteisLoading.value = true;

    try {
      if (isFavorite) {
        await personRepository.deletePersonLocal(person.id);
        isFavorite = false;
      } else {
        await personRepository.savePerson(person);
        isFavorite = true;
      }
    } catch (e) {
      developer.log('Erro ao atualizar favorito: $e');
      rethrow;
    } finally {
      buttonFavoriteisLoading.value = false;
    }
  }

  void dispose() {
    buttonFavoriteisLoading.dispose();
  }
}
