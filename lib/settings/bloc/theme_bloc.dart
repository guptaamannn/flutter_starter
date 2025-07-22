import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.system)) {
    on<ThemeChanged>(_onThemeChanged);
    on<ThemeLoaded>(_onThemeLoaded);
    add(const ThemeLoaded());
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_preference', event.themeMode.index);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _onThemeLoaded(
    ThemeLoaded event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt('theme_preference');
    final themeMode = savedIndex != null
        ? ThemeMode.values[savedIndex]
        : ThemeMode.system;
    emit(state.copyWith(themeMode: themeMode));
  }
}
