import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_todos/features/todos/provider/todos_provider.dart';

part 'todos_stats_provider.g.dart';

@riverpod
class Stats extends _$Stats {
  @override
  StatsState build() {
    // Watch the todos provider and transform its state
    final todosAsync = ref.watch(todosProvider);

    return todosAsync.when(
      loading: () => const StatsState(completedTodos: 0, activeTodos: 0),
      error: (_, __) => const StatsState(completedTodos: 0, activeTodos: 0),
      data: (todos) => StatsState(
        completedTodos: todos.where((t) => t.isCompleted).length,
        activeTodos: todos.where((t) => !t.isCompleted).length,
      ),
    );
  }
}

class StatsState {
  const StatsState({required this.completedTodos, required this.activeTodos});

  final int completedTodos;
  final int activeTodos;
}
