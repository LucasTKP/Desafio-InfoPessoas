import 'package:flutter/material.dart';
import 'package:infopessoas/data/repositories/person/person_repository.dart';
import 'package:infopessoas/domain/models/people/person_model.dart';
import 'package:infopessoas/core/extension/datetime_extension.dart';
import 'package:infopessoas/core/services/dependency_injection_service.dart';
import 'package:infopessoas/core/services/identify_error_service.dart';
import 'package:infopessoas/core/services/material_banner_service.dart';
import 'package:infopessoas/ui/core/widgets/default_screen.dart';
import 'package:infopessoas/ui/details_person/viewmodel/details_person_viewmodel.dart';
import 'package:infopessoas/ui/details_person/widgets/button_favorite.dart';
import 'package:infopessoas/ui/details_person/widgets/hero_person.dart';
import 'package:infopessoas/ui/details_person/widgets/info_card.dart';
import 'package:infopessoas/ui/details_person/widgets/info_row.dart';

class DetailsPersonScreen extends StatefulWidget {
  final PersonModel person;
  const DetailsPersonScreen({super.key, required this.person});

  @override
  State<DetailsPersonScreen> createState() => _DetailsPersonScreenState();
}

class _DetailsPersonScreenState extends State<DetailsPersonScreen> {
  late MaterialBannerService snackBarService;
  late DetailsPersonViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    snackBarService = getIt<MaterialBannerService>();
    viewmodel = DetailsPersonViewmodel(personRepository: getIt<PersonRepository>());
    initialize();
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  late final padding = MediaQuery.paddingOf(context);

  void initialize() {
    viewmodel.initialize(widget.person.id).catchError((e) {
      if (mounted) {
        snackBarService.showBanner(
          context: context,
          message: identifyError(error: e, message: "Erro ao verificar favorito."),
          color: Colors.red,
        );
      }
    });
  }

  void toogleFavorite(PersonModel person) {
    viewmodel.toggleFavorite(person).catchError((e) {
      if (mounted) {
        snackBarService.showBanner(
          context: context,
          message: identifyError(error: e, message: "Erro ao atualizar favorito."),
          color: Colors.red,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final person = widget.person;

    return DefaultScreen(
      titleAppBar: 'Detalhes',
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroPerson(person: person),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  InfoCard(
                    title: 'Contato',
                    icon: Icons.contact_phone,
                    color: Colors.blue,
                    children: [
                      InfoRowCard(icon: Icons.email, label: 'Email', value: person.email),
                      const Divider(height: 24),
                      InfoRowCard(icon: Icons.phone_android, label: 'Celular', value: person.cell),
                    ],
                  ),
                  const SizedBox(height: 16),
                  InfoCard(
                    title: 'Informações Pessoais',
                    icon: Icons.person_outline,
                    color: Colors.purple,
                    children: [
                      InfoRowCard(icon: Icons.cake, label: 'Data de Nascimento', value: person.dob.date.toDDMMYYYY()),
                      const Divider(height: 24),
                      InfoRowCard(icon: Icons.calendar_today, label: 'Idade', value: '${person.dob.age} anos'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  InfoCard(
                    title: 'Endereço',
                    icon: Icons.location_on,
                    color: Colors.orange,
                    children: [
                      InfoRowCard(icon: Icons.home, label: 'Rua', value: '${person.location.street.name}, ${person.location.street.number}'),
                      const Divider(height: 24),
                      InfoRowCard(icon: Icons.location_city, label: 'Cidade', value: person.location.city),
                      const Divider(height: 24),
                      InfoRowCard(icon: Icons.map, label: 'Estado', value: person.location.state),
                      const Divider(height: 24),
                      InfoRowCard(icon: Icons.public, label: 'País', value: person.location.country),
                      const Divider(height: 24),
                      InfoRowCard(icon: Icons.markunread_mailbox, label: 'CEP', value: person.location.postcode),
                    ],
                  ),

                  SizedBox(height: padding.bottom + 8),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: viewmodel.buttonFavoriteisLoading,
        builder: (context, isLoading, child) {
          return ButtonFavorite(
            isLoading: isLoading,
            isFavorite: viewmodel.isFavorite,
            onPressed: () {
              toogleFavorite(person);
            },
          );
        },
      ),
    );
  }
}
