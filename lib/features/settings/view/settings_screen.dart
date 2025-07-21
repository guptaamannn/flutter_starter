import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos/features/settings/provider/theme_provider.dart';
import 'package:flutter_todos/l10n/l10n.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsAppBarTitle)),
      body: ListView(
        children: [
          ListTile(
            title: Text(l10n.settingsThemeLabel),
            trailing: DropdownButton<ThemeMode>(
              value: currentTheme,
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(l10n.settingsThemeSystem),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(l10n.settingsThemeLight),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(l10n.settingsThemeDark),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeNotifierProvider.notifier).updateTheme(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
