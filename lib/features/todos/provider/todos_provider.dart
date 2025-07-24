import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos/core/providers/shared_preferences_provider.dart';
import 'package:flutter_todos/features/todos/data/local_storage_todos_api.dart';
import 'package:flutter_todos/features/todos/data/todos_api.dart';
import 'package:flutter_todos/features/todos/data/todos_repository.dart';
import 'package:flutter_todos/features/todos/model/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todos_provider.g.dart';

@Riverpod(keepAlive: true)
TodosApi todosApi(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalStorageTodosApi(plugin: prefs);
}

@Riverpod(keepAlive: true)
TodosRepository todosRepository(Ref ref) {
  final todosApi = ref.watch(todosApiProvider);
  return TodosRepository(todosApi: todosApi);
}

@riverpod
Stream<List<Todo>> todos(Ref ref) {
  return ref.watch(todosRepositoryProvider).getTodos();
}
