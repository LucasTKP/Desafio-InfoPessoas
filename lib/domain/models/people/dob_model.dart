import 'package:infopessoas/core/extension/string_extension.dart';

class DobModel {
  final DateTime date;
  final int age;

  DobModel({required this.date, required this.age});

  factory DobModel.fromJson(Map<String, dynamic> json) => DobModel(
    date: (json['date'] as String).toDateTime(),
    age: json['age'],
  );

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'age': age,
  };
}
