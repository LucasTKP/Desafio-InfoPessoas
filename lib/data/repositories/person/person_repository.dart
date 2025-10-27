import 'dart:convert';

import 'package:infopessoas/domain/models/people/person_model.dart';
import 'package:infopessoas/core/services/api_client_service.dart';
import 'package:infopessoas/core/services/local_database_service.dart';

class PersonRepository {
  final ApiClientService apiClientService;
  final LocalDatabaseService localDatabaseService;

  PersonRepository({required this.apiClientService, required this.localDatabaseService});

  static const String table = 'favorite_persons';

  Future<PersonModel> fetchRandomPerson() async {
    final response = await apiClientService.get(
      endpoint: '',
      logMessage: 'Fetching random person in api',
    );

    final data = response.data;
    return PersonModel.fromJson(data['results'][0] as Map<String, dynamic>);
  }

  Future<void> savePerson(PersonModel person) async {
    final jsonData = jsonEncode(person.toJson());
    await localDatabaseService.save(
      table: table,
      id: person.id,
      jsonData: jsonData,
      action: 'Favoritando pessoa',
    );
  }

  Future<void> deletePersonLocal(String personId) async {
    await localDatabaseService.delete(
      table: table,
      id: personId,
      action: 'Removendo pessoa dos favoritos',
    );
  }

  Future<PersonModel?> getPersonById(String personId) async {
    final result = await localDatabaseService.getById(
      table: table,
      id: personId,
      action: 'Buscando pessoa por ID nos favoritos',
    );

    if (result != null) {
      return PersonModel.fromJson(result);
    } else {
      return null;
    }
  }

  Future<List<PersonModel>> getAllFavoritePersons() async {
    final result = await localDatabaseService.getAll(table: table, action: 'Buscando todas as pessoas favoritas');
    return result.map((map) {
      return PersonModel.fromJson(map);
    }).toList();
  }
}
