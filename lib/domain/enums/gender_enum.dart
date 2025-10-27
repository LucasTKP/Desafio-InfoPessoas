import 'package:flutter/material.dart';

enum GenderEnum {
  female,
  male;

  String get description {
    switch (this) {
      case GenderEnum.female:
        return 'Mulher';
      case GenderEnum.male:
        return 'Homem';
    }
  }

  Color get color {
    switch (this) {
      case GenderEnum.female:
        return Colors.pink;
      case GenderEnum.male:
        return Colors.blue;
    }
  }


  IconData get icon {
    switch (this) {
      case GenderEnum.female:
        return Icons.female;
      case GenderEnum.male:
        return Icons.male;
    }}
}
