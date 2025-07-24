import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todos/features/settings/provider/theme_provider.dart';
import 'package:flutter_todos/l10n/app_localizations.dart';
import 'package:flutter_todos/theme/theme.dart';
import 'package:flutter_todos/features/todos/ui/screens/home_screen.dart';
import 'package:flutter_todos/theme/util.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    TextTheme textTheme = createTextTheme(
      context,
      "Merriweather Sans",
      "Oswald",
    );

    MaterialTheme theme = MaterialTheme(textTheme);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.light(),
        darkTheme: theme.dark(),
        themeMode: themeMode,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [
          Locale('en'), // English
          // Add other supported locales here
        ],
        home: const HomePage(),
      ),
    );
  }
}
