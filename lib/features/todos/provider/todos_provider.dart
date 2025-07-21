import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos/features/todos/data/local_storage_todos_api.dart';
import 'package:flutter_todos/features/todos/data/todos_api.dart';
import 'package:flutter_todos/features/todos/data/todos_repository.dart';
import 'package:flutter_todos/features/todos/model/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'todos_provider.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('Should be overridden in main.dart');
}

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

@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> addTodo(Todo todo) async {
    await ref.read(todosRepositoryProvider).saveTodo(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await ref.read(todosRepositoryProvider).saveTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await ref.read(todosRepositoryProvider).deleteTodo(id);
  }

  Future<int> clearCompleted() async {
    return await ref.read(todosRepositoryProvider).clearCompleted();
  }

  Future<int> toggleAll({required bool isCompleted}) async {
    return await ref
        .read(todosRepositoryProvider)
        .completeAll(isCompleted: isCompleted);
  }

  Future<void> toggleTodo(Todo todo) async {
    await ref
        .read(todosRepositoryProvider)
        .saveTodo(todo.copyWith(isCompleted: !todo.isCompleted));
  }
}
