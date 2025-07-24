import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos/features/todos/provider/todos_overview_provider.dart';
import 'package:flutter_todos/l10n/l10n.dart';

@visibleForTesting
enum TodosOverviewOption { toggleAll, clearCompleted }

class TodosOverviewOptionsButton extends ConsumerWidget {
  const TodosOverviewOptionsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final todos = ref.watch(todosOverviewProvider).todos;
    final hasTodos = todos.isNotEmpty;
    final completedTodosAmount = todos.where((todo) => todo.isCompleted).length;

    return PopupMenuButton<TodosOverviewOption>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      tooltip: l10n.todosOverviewOptionsTooltip,
      onSelected: (options) async {
        switch (options) {
          case TodosOverviewOption.toggleAll:
            final areAllCompleted = todos.every((t) => t.isCompleted);
            await ref
                .read(todosOverviewProvider.notifier)
                .toggleAll(isCompleted: !areAllCompleted);

          case TodosOverviewOption.clearCompleted:
            ref.read(todosOverviewProvider.notifier).clearCompleted();
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TodosOverviewOption.toggleAll,
            enabled: hasTodos,
            child: Text(
              completedTodosAmount == todos.length
                  ? l10n.todosOverviewOptionsMarkAllIncomplete
                  : l10n.todosOverviewOptionsMarkAllComplete,
            ),
          ),
          PopupMenuItem(
            value: TodosOverviewOption.clearCompleted,
            enabled: hasTodos && completedTodosAmount > 0,
            child: Text(l10n.todosOverviewOptionsClearCompleted),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}
