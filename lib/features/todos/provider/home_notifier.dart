import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

enum HomeTab { todos, stats, settings }

@riverpod
class HomeTabNotifier extends _$HomeTabNotifier {
  @override
  HomeTab build() => HomeTab.todos;

  void set(HomeTab tab) => state = tab;
}
