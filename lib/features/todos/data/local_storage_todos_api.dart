import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import '../model/todo.dart';
import 'todos_api.dart';

class LocalStorageTodosApi extends TodosApi {
  LocalStorageTodosApi({required SharedPreferences plugin}) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;
  late final _controller = BehaviorSubject<List<Todo>>.seeded(const []);

  static const kKey = '__todos__';

  void _init() {
    final raw = _plugin.getString(kKey);
    if (raw != null) {
      final list = (json.decode(raw) as List)
          .map((e) => Todo.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      _controller.add(list);
    }
  }

  Future<void> _write(List<Todo> todos) async {
    _controller.add(todos);
    await _plugin.setString(
      kKey,
      json.encode(todos.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Stream<List<Todo>> getTodos() => _controller.stream;

  @override
  Future<void> saveTodo(Todo todo) async {
    final todos = [..._controller.value];
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index == -1) {
      todos.add(todo);
    } else {
      todos[index] = todo;
    }
    await _write(todos);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = [..._controller.value];
    final index = todos.indexWhere((t) => t.id == id);
    if (index == -1) throw TodoNotFoundException();
    todos.removeAt(index);
    await _write(todos);
  }

  @override
  Future<int> clearCompleted() async {
    final todos = [..._controller.value];
    final original = todos.length;
    todos.removeWhere((t) => t.isCompleted);
    await _write(todos);
    return original - todos.length;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final todos = _controller.value
        .map((t) => t.copyWith(isCompleted: isCompleted))
        .toList();
    await _write(todos);
    return todos.length;
  }

  @override
  Future<void> close() async {
    await _controller.close();
  }
}
