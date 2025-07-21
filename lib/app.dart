import 'package:flutter/material.dart';
import 'package:flutter_todos/l10n/app_localizations.dart';
import 'package:flutter_todos/theme/theme.dart';
import 'package:flutter_todos/features/todos/ui/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterTodosTheme.light,
      darkTheme: FlutterTodosTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'), // English
        // Add other supported locales here
      ],
      home: const HomePage(),
    );
  }
}
