import 'package:get_it/get_it.dart';
import 'package:infopessoas/data/repositories/person/person_repository.dart';
import 'package:infopessoas/core/services/api_client_service.dart';
import 'package:infopessoas/core/services/local_database_service.dart';
import 'package:infopessoas/core/services/material_banner_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> injectDependencies() async {
  await getIt.reset();

  getIt.registerLazySingleton(() => ApiClientService());
  getIt.registerLazySingleton(() => LocalDatabaseService());
  getIt.registerLazySingleton(() => MaterialBannerService());
  getIt.registerLazySingleton<PersonRepository>(
    () => PersonRepository(
      apiClientService: getIt<ApiClientService>(),
      localDatabaseService: getIt<LocalDatabaseService>()
    ),
  );
}
