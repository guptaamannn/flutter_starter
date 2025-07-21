import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos/features/todos/model/todo.dart';
import 'package:flutter_todos/features/todos/provider/todos_edit_provider.dart';
import 'package:flutter_todos/l10n/l10n.dart';

class EditTodoPage extends StatelessWidget {
  const EditTodoPage({super.key, this.initialTodo});
  final Todo? initialTodo;

  static Route<void> route({Todo? initialTodo}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => EditTodoPage(initialTodo: initialTodo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EditTodoView(initialTodo: initialTodo);
  }
}

class EditTodoView extends ConsumerWidget {
  const EditTodoView({super.key, this.initialTodo});
  final Todo? initialTodo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(editTodoProvider(initialTodo: initialTodo));
    final notifier = ref.read(
      editTodoProvider(initialTodo: initialTodo).notifier,
    );

    ref.listen(editTodoProvider(initialTodo: initialTodo), (previous, next) {
      if (previous?.status != EditTodoStatus.success &&
          next.status == EditTodoStatus.success) {
        Navigator.of(context).pop();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.isNewTodo
              ? l10n.editTodoAddAppBarTitle
              : l10n.editTodoEditAppBarTitle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.editTodoSaveButtonTooltip,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        onPressed: state.status.isLoadingOrSuccess
            ? null
            : () => notifier.submit(),
        child: state.status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _TitleField(initialTodo: initialTodo),
                _DescriptionField(initialTodo: initialTodo),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends ConsumerWidget {
  const _TitleField({this.initialTodo});
  final Todo? initialTodo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(editTodoProvider(initialTodo: initialTodo));
    final notifier = ref.read(
      editTodoProvider(initialTodo: initialTodo).notifier,
    );

    final hintText = state.initialTodo?.title ?? '';

    return TextFormField(
      key: const Key('editTodoView_title_textFormField'),
      initialValue: state.title,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: l10n.editTodoTitleLabel,
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: notifier.titleChanged,
    );
  }
}

class _DescriptionField extends ConsumerWidget {
  const _DescriptionField({this.initialTodo});
  final Todo? initialTodo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(editTodoProvider(initialTodo: initialTodo));
    final notifier = ref.read(
      editTodoProvider(initialTodo: initialTodo).notifier,
    );

    final hintText = state.initialTodo?.description ?? '';

    return TextFormField(
      key: const Key('editTodoView_description_textFormField'),
      initialValue: state.description,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: l10n.editTodoDescriptionLabel,
        hintText: hintText,
      ),
      maxLength: 300,
      maxLines: 7,
      inputFormatters: [LengthLimitingTextInputFormatter(300)],
      onChanged: notifier.descriptionChanged,
    );
  }
}
