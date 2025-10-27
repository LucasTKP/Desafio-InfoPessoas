import 'package:flutter/material.dart';
import 'package:infopessoas/core/services/dependency_injection_service.dart';
import 'package:infopessoas/ui/core/themes/theme.dart';
import 'package:infopessoas/ui/list_persons/widgets/list_persons_scren.dart';

void main() async {
  await injectDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty',
      theme: ThemeData(
        fontFamily: CustomTheme.fontFamily,
        useMaterial3: true,
        textTheme: CustomTheme.text(context),
        progressIndicatorTheme: CustomTheme.progressIndicatorTheme(context),
        appBarTheme: CustomTheme.appBarTheme(context),
        scaffoldBackgroundColor: Color(0xFFF4F4F5),
        bottomSheetTheme: CustomTheme.bottomSheetTheme(context),
        floatingActionButtonTheme: CustomTheme.floatingActionButtonTheme(context),
      ),
      home: ListPersonsScren(),
    );
  }
}
