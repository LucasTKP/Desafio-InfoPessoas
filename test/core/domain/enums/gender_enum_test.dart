import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infopessoas/domain/enums/gender_enum.dart';

void main() {
  group('GenderEnum', () {
    test('deve ter os valores corretos', () {
      expect(GenderEnum.values.length, 2);
      expect(GenderEnum.values, containsAll([GenderEnum.female, GenderEnum.male]));
    });

    group('description', () {
      test('deve retornar "Mulher" para female', () {
        expect(GenderEnum.female.description, 'Mulher');
      });

      test('deve retornar "Homem" para male', () {
        expect(GenderEnum.male.description, 'Homem');
      });
    });

    group('color', () {
      test('deve retornar Colors.pink para female', () {
        expect(GenderEnum.female.color, Colors.pink);
      });

      test('deve retornar Colors.blue para male', () {
        expect(GenderEnum.male.color, Colors.blue);
      });
    });

    group('icon', () {
      test('deve retornar Icons.female para female', () {
        expect(GenderEnum.female.icon, Icons.female);
      });

      test('deve retornar Icons.male para male', () {
        expect(GenderEnum.male.icon, Icons.male);
      });
    });

    group('byName', () {
      test('deve retornar female quando passar "female"', () {
        expect(GenderEnum.values.byName('female'), GenderEnum.female);
      });

      test('deve retornar male quando passar "male"', () {
        expect(GenderEnum.values.byName('male'), GenderEnum.male);
      });
    });
  });
}
