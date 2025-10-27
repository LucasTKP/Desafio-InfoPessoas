import 'package:flutter/material.dart';
import 'package:infopessoas/data/repositories/person/person_repository.dart';
import 'package:infopessoas/domain/enums/gender_enum.dart';
import 'package:infopessoas/domain/enums/state_screen.dart';
import 'package:infopessoas/domain/models/people/person_model.dart';
import 'package:infopessoas/core/services/dependency_injection_service.dart';
import 'package:infopessoas/core/services/identify_error_service.dart';
import 'package:infopessoas/core/services/material_banner_service.dart';
import 'package:infopessoas/ui/core/widgets/custom_circular_progress.dart';

import 'package:infopessoas/ui/core/widgets/default_screen.dart';
import 'package:infopessoas/ui/details_person/widgets/details_person_screen.dart';
import 'package:infopessoas/ui/list_favorite_persons/viewmodels/list_favorite_persons_viewmodel.dart';
import 'package:infopessoas/ui/core/widgets/person_card.dart';
import 'package:infopessoas/ui/list_favorite_persons/widgets/favorite_button.dart';

class ListFavoritePersonsScreen extends StatefulWidget {
  const ListFavoritePersonsScreen({super.key});

  @override
  State<ListFavoritePersonsScreen> createState() => _ListFavoritePersonsScreenState();
}

class _ListFavoritePersonsScreenState extends State<ListFavoritePersonsScreen> {
  late ListFavoritePersonsViewmodel viewmodel;
  late MaterialBannerService snackBarService;

  @override
  void initState() {
    super.initState();
    viewmodel = ListFavoritePersonsViewmodel(personRepository: getIt<PersonRepository>());
    snackBarService = getIt<MaterialBannerService>();
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreen(
      titleAppBar: 'Favoritos',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 16),
            Expanded(
              child: ListenableBuilder(
                listenable: viewmodel,
                builder: (context, _) {
                  final state = viewmodel.stateScreen;
                  if (state == StateScreen.loading) {
                    return Center(child: CustomCircularProgress());
                  }
                  if (state == StateScreen.error) {
                    return Center(child: Text('Erro ao carregar favoritos.'));
                  }
                  if (viewmodel.favoritePersons.isEmpty) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.heart_broken, size: 80, color: Colors.grey[400]),
                          SizedBox(height: 8),
                          Text('A lista de favoritos esta vazia.', style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: viewmodel.favoritePersons.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final person = viewmodel.favoritePersons[index];
                      return PersonCard(
                        person: person,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailsPersonScreen(person: person)),
                          );
                          await viewmodel.fetchFavoritePersons();
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FavoriteButton(onTap: () async => await removeFromFavorites(person)),
                            Icon(Icons.arrow_forward_ios, size: 24, color: Colors.black45),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> removeFromFavorites(PersonModel person) async {
    try {
      await viewmodel.removeFromFavorites(person.id);
      if (mounted) {
        snackBarService.showBanner(
          context: context,
          message: '${person.name.first} ${person.gender == GenderEnum.male ? 'removido' : 'removida'} dos favoritos com sucesso!',
          color: Colors.green,
        );
      }
    } catch (e) {
      if (mounted) {
        snackBarService.showBanner(
          context: context,
          message: identifyError(error: e, message: 'Erro ao remover dos favoritos.'),
          color: Colors.red,
        );
      }
    }
  }
}
