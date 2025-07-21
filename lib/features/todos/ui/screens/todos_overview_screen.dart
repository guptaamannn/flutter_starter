import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos/features/todos/provider/todos_overview_provider.dart';
import 'package:flutter_todos/features/todos/ui/screens/edit_todo_screen.dart';
import 'package:flutter_todos/features/todos/ui/widgets/widgets.dart';
import 'package:flutter_todos/l10n/l10n.dart';

class TodosOverviewPage extends StatelessWidget {
  const TodosOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TodosOverviewView();
  }
}

class TodosOverviewView extends ConsumerWidget {
  const TodosOverviewView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(todosOverviewProvider);
    final notifier = ref.read(todosOverviewProvider.notifier);
    final messenger = ScaffoldMessenger.of(context);

    ref.listen(todosOverviewProvider.select((s) => s.status), (prev, next) {
      if (next == TodosOverviewStatus.failure) {
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(l10n.todosOverviewErrorSnackbarText)),
          );
      }
    });

    ref.listen(todosOverviewProvider.select((s) => s.lastDeletedTodo), (
      prev,
      next,
    ) {
      if (next != null) {
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                l10n.todosOverviewTodoDeletedSnackbarText(next.title),
              ),
              action: SnackBarAction(
                label: l10n.todosOverviewUndoDeletionButtonText,
                onPressed: () {
                  messenger.hideCurrentSnackBar();
                  notifier.undoDelete();
                },
              ),
            ),
          );
      }
    });

    if (state.todos.isEmpty) {
      if (state.status == TodosOverviewStatus.loading) {
        return const Center(child: CupertinoActivityIndicator());
      } else if (state.status != TodosOverviewStatus.success) {
        return const SizedBox();
      } else {
        return Center(
          child: Text(
            l10n.todosOverviewEmptyText,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        );
      }
    }

    return CupertinoScrollbar(
      child: ListView.builder(
        itemCount: state.filteredTodos.length,
        itemBuilder: (_, index) {
          final todo = state.filteredTodos.elementAt(index);
          return TodoListTile(
            todo: todo,
            onToggleCompleted: (isCompleted) async {
              await notifier.toggleTodo(todo: todo, isCompleted: isCompleted);
            },
            onDismissed: (_) async {
              await notifier.deleteTodo(todo.id);
            },
            onTap: () {
              Navigator.of(context).push(EditTodoPage.route(initialTodo: todo));
            },
          );
        },
      ),
    );
  }
}
