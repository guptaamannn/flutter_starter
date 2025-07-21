// lib/features/settings/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_todos/core/providers/shared_preferences_provider.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    // Load immediately during provider initialization
    return _loadTheme();
  }

  ThemeMode _loadTheme() {
    final prefs = ref.read(sharedPreferencesProvider);
    final savedIndex = prefs.getInt('theme_preference');
    return savedIndex != null ? ThemeMode.values[savedIndex] : ThemeMode.system;
  }

  Future<void> updateTheme(ThemeMode theme) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setInt('theme_preference', theme.index);
    state = theme; // Update state after saving
  }
}
