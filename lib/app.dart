import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos/features/settings/provider/theme_provider.dart';
import 'package:flutter_todos/l10n/app_localizations.dart';
import 'package:flutter_todos/theme/theme.dart';
import 'package:flutter_todos/features/todos/ui/screens/home_screen.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: FlutterTodosTheme.light,
      darkTheme: FlutterTodosTheme.dark,
      themeMode: themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'), // English
        // Add other supported locales here
      ],
      home: const HomePage(),
    );
  }
}
