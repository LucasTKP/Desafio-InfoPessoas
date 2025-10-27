import 'package:flutter/material.dart';
import 'package:infopessoas/data/repositories/person/person_repository.dart';
import 'package:infopessoas/domain/models/people/person_model.dart';
import 'package:infopessoas/core/services/dependency_injection_service.dart';
import 'package:infopessoas/ui/core/themes/extensions.dart';
import 'package:infopessoas/ui/core/widgets/default_button.dart';
import 'package:infopessoas/ui/core/widgets/default_screen.dart';
import 'package:infopessoas/ui/details_person/widgets/details_person_screen.dart';
import 'package:infopessoas/ui/list_favorite_persons/widgets/list_favorite_persons_screen.dart';
import 'package:infopessoas/ui/list_persons/viewmodels/list_persons_viewmodel.dart';
import 'package:infopessoas/ui/list_persons/widgets/error_card.dart';
import 'package:infopessoas/ui/list_persons/widgets/loading_card.dart';
import 'package:infopessoas/ui/core/widgets/person_card.dart';

class ListPersonsScren extends StatefulWidget {
  const ListPersonsScren({super.key});

  @override
  State<ListPersonsScren> createState() => _ListPersonsScrenState();
}

class _ListPersonsScrenState extends State<ListPersonsScren> with TickerProviderStateMixin {
  late ListPersonsViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = ListPersonsViewmodel(
      personRepository: getIt<PersonRepository>(),
      vsync: this,
    );
    viewmodel.startTicker();
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  late final padding = MediaQuery.paddingOf(context);

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      titleAppBar: 'Lista de Pessoas',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  ValueListenableBuilder<List<PersonModel>>(
                    valueListenable: viewmodel.persons,
                    builder: (context, persons, _) {
                      if (persons.isEmpty) {
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_off, size: 80, color: Colors.grey[400]),
                              SizedBox(height: 8),
                              Text('A lista de pessoas esta vazia.', style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final person = persons[index];
                          return PersonCard(
                            person: person,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DetailsPersonScreen(person: person)),
                              );
                            },
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemCount: persons.length,
                      );
                    },
                  ),
                  LoadingCard(isLoading: viewmodel.isLoading),
                  ErrorCard(tryAgain: viewmodel.fetchPersons, error: viewmodel.errorMessage),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8 + padding.bottom, top: 8, left: 16, right: 16),
            color: Colors.white,
            child: DefaultButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListFavoritePersonsScreen()),
                );
              },
              label: "Favoritos",
              icon: Icon(Icons.storage, size: 24, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
