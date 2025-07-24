import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_todos/features/todos/model/todo.dart';
import 'package:flutter_todos/features/todos/model/todos_view_filter.dart';
import 'package:flutter_todos/features/todos/provider/todos_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todos_overview_provider.g.dart';

enum TodosOverviewStatus { initial, loading, success, failure }

final class TodosOverviewState extends Equatable {
  const TodosOverviewState({
    this.status = TodosOverviewStatus.initial,
    this.todos = const [],
    this.filter = TodosViewFilter.all,
    this.lastDeletedTodo,
    this.error,
  });

  final TodosOverviewStatus status;
  final List<Todo> todos;
  final TodosViewFilter filter;
  final Todo? lastDeletedTodo;
  final String? error;

  Iterable<Todo> get filteredTodos => filter.applyAll(todos);

  TodosOverviewState copyWith({
    TodosOverviewStatus? status,
    List<Todo>? todos,
    TodosViewFilter? filter,
    Todo? lastDeletedTodo,
    String? error,
  }) {
    return TodosOverviewState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      filter: filter ?? this.filter,
      lastDeletedTodo: lastDeletedTodo ?? this.lastDeletedTodo,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, todos, filter, lastDeletedTodo, error];
}

@riverpod
class TodosOverview extends _$TodosOverview {
  StreamSubscription<List<Todo>>? _todosSubscription;

  @override
  TodosOverviewState build() {
    // Initialize with loading state
    state = const TodosOverviewState(status: TodosOverviewStatus.loading);

    // Subscribe to todos stream
    _todosSubscription = ref
        .watch(todosRepositoryProvider)
        .getTodos()
        .listen(
          (todos) {
            state = state.copyWith(
              todos: todos,
              status: TodosOverviewStatus.success,
              error: null,
            );
          },
          onError: (error, _) {
            state = state.copyWith(
              status: TodosOverviewStatus.failure,
              error: error.toString(),
            );
          },
        );

    // Setup cleanup
    ref.onDispose(() {
      _todosSubscription?.cancel();
    });

    return state;
  }

  Future<void> setFilter(TodosViewFilter filter) async {
    state = state.copyWith(filter: filter);
  }

  Future<void> deleteTodo(String id) async {
    final todoToDelete = state.todos.firstWhere((t) => t.id == id);
    try {
      state = state.copyWith(
        lastDeletedTodo: todoToDelete,
        status: TodosOverviewStatus.loading,
      );
      await ref.read(todosRepositoryProvider).deleteTodo(id);
    } catch (e) {
      state = state.copyWith(
        status: TodosOverviewStatus.failure,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> undoDelete() async {
    if (state.lastDeletedTodo == null) return;

    try {
      await ref.read(todosRepositoryProvider).saveTodo(state.lastDeletedTodo!);
      state = state.copyWith(lastDeletedTodo: null);
    } catch (e) {
      state = state.copyWith(
        status: TodosOverviewStatus.failure,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> toggleAll({required bool isCompleted}) async {
    try {
      state = state.copyWith(status: TodosOverviewStatus.loading);
      await ref
          .read(todosRepositoryProvider)
          .completeAll(isCompleted: isCompleted);
    } catch (e) {
      state = state.copyWith(
        status: TodosOverviewStatus.failure,
        error: e.toString(),
      );
      rethrow;
    }
  }

  // Implement toggle todod
  Future<void> toggleTodo({
    required Todo todo,
    required bool isCompleted,
  }) async {
    try {
      state = state.copyWith(status: TodosOverviewStatus.loading);
      await ref
          .read(todosRepositoryProvider)
          .saveTodo(todo.copyWith(isCompleted: isCompleted));
    } catch (e) {
      state = state.copyWith(
        status: TodosOverviewStatus.failure,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> clearCompleted() async {
    try {
      state = state.copyWith(status: TodosOverviewStatus.loading);
      await ref.read(todosRepositoryProvider).clearCompleted();
    } catch (e) {
      state = state.copyWith(
        status: TodosOverviewStatus.failure,
        error: e.toString(),
      );
      rethrow;
    }
  }
}
