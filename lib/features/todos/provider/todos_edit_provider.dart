import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_todos/features/todos/data/todos_repository.dart';
import 'package:flutter_todos/features/todos/model/todo.dart';
import 'package:flutter_todos/features/todos/provider/todos_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todos_edit_provider.g.dart';

enum EditTodoStatus { initial, loading, success, failure }

extension EditTodoStatusX on EditTodoStatus {
  bool get isLoadingOrSuccess =>
      [EditTodoStatus.loading, EditTodoStatus.success].contains(this);
}

final class EditTodoState extends Equatable {
  const EditTodoState({
    this.status = EditTodoStatus.initial,
    this.initialTodo,
    this.title = '',
    this.description = '',
  });

  final EditTodoStatus status;
  final Todo? initialTodo;
  final String title;
  final String description;

  bool get isNewTodo => initialTodo == null;

  EditTodoState copyWith({
    EditTodoStatus? status,
    Todo? initialTodo,
    String? title,
    String? description,
  }) {
    return EditTodoState(
      status: status ?? this.status,
      initialTodo: initialTodo ?? this.initialTodo,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [status, initialTodo, title, description];
}

@riverpod
class EditTodo extends _$EditTodo {
  late final TodosRepository _repository;

  @override
  EditTodoState build({Todo? initialTodo}) {
    _repository = ref.read(
      todosRepositoryProvider,
    ); // make sure this provider exists
    return EditTodoState(
      initialTodo: initialTodo,
      title: initialTodo?.title ?? '',
      description: initialTodo?.description ?? '',
    );
  }

  void titleChanged(String value) {
    state = state.copyWith(title: value);
  }

  void descriptionChanged(String value) {
    state = state.copyWith(description: value);
  }

  Future<void> submit() async {
    if (state.status.isLoadingOrSuccess) return;
    log(
      'title :${state.title}, description: ${state.description}}',
      name: 'EditTodo',
    );

    state = state.copyWith(status: EditTodoStatus.loading);
    try {
      final todo = (state.initialTodo ?? Todo(title: '')).copyWith(
        title: state.title,
        description: state.description,
      );

      await _repository.saveTodo(todo);
      state = state.copyWith(status: EditTodoStatus.success);
    } catch (_) {
      state = state.copyWith(status: EditTodoStatus.initial);
    }
  }
}
