import 'package:flutter/material.dart';
import 'package:infopessoas/domain/models/people/person_model.dart';
import 'package:infopessoas/ui/core/themes/extensions.dart';

class HeroPerson extends StatelessWidget {
  final PersonModel person;
  const HeroPerson({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Hero(
          tag: 'person_${person.email}',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 15, spreadRadius: 2)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(person.pictureUrl, width: 140, height: 140, fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${person.name.title} ${person.name.first} ${person.name.last}',
          style: context.textTheme.titleLarge,
        ),

        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: person.gender.color.withAlpha(40),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: person.gender.color, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                person.gender.icon,
                color: person.gender.color,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                person.gender.description,
                style: context.textTheme.bodySmall?.copyWith(color: person.gender.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
