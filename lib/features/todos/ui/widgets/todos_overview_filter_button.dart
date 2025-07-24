import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos/features/todos/model/todos_view_filter.dart';
import 'package:flutter_todos/features/todos/provider/todos_overview_provider.dart';
import 'package:flutter_todos/l10n/l10n.dart';

class TodosOverviewFilterButton extends ConsumerWidget {
  const TodosOverviewFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final currentFilter = ref.watch(todosOverviewProvider).filter;

    return PopupMenuButton<TodosViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: currentFilter,
      tooltip: l10n.todosOverviewFilterTooltip,
      onSelected: (filter) {
        ref.read(todosOverviewProvider.notifier).setFilter(filter);
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TodosViewFilter.all,
            child: Text(l10n.todosOverviewFilterAll),
          ),
          PopupMenuItem(
            value: TodosViewFilter.activeOnly,
            child: Text(l10n.todosOverviewFilterActiveOnly),
          ),
          PopupMenuItem(
            value: TodosViewFilter.completedOnly,
            child: Text(l10n.todosOverviewFilterCompletedOnly),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
