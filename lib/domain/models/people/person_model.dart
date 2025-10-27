import 'package:infopessoas/domain/enums/gender_enum.dart';

import 'name_model.dart';
import 'location_model.dart';
import 'dob_model.dart';

class PersonModel {
  final String id;
  final GenderEnum gender;
  final NameModel name;
  final LocationModel location;
  final String email;
  final DobModel dob;
  final String cell;
  final String pictureUrl;

  PersonModel({
    required this.id,
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.dob,
    required this.cell,
    required this.pictureUrl,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    id: json['login']['uuid'] as String,
    gender: GenderEnum.values.byName(json['gender'].toLowerCase() as String),
    name: NameModel.fromJson(json['name'] as Map<String, dynamic>),
    location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    email: json['email'] as String,
    dob: DobModel.fromJson(json['dob'] as Map<String, dynamic>),
    cell: json['cell'] as String,
    pictureUrl: json['picture']['large'] as String,
  );

  Map<String, dynamic> toJson() => {
    'login': {'uuid': id},
    'gender': gender.name,
    'name': name.toJson(),
    'location': location.toJson(),
    'email': email,
    'dob': dob.toJson(),
    'cell': cell,
    'picture': {'large': pictureUrl},
  };

  String get fullName => '${name.title} ${name.first} ${name.last}';

}
