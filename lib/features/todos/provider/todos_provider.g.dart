// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'ee82ca901499dbe399ddaa3e1f851a7be5ab93b4';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = Provider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = ProviderRef<SharedPreferences>;
String _$todosApiHash() => r'a00c0faabbc8dc37a6082b8a093605384bac38a3';

/// See also [todosApi].
@ProviderFor(todosApi)
final todosApiProvider = Provider<TodosApi>.internal(
  todosApi,
  name: r'todosApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todosApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodosApiRef = ProviderRef<TodosApi>;
String _$todosRepositoryHash() => r'0c6b29f86a2e47d1d02f7e8d4595f2fcaa54afd2';

/// See also [todosRepository].
@ProviderFor(todosRepository)
final todosRepositoryProvider = Provider<TodosRepository>.internal(
  todosRepository,
  name: r'todosRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todosRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodosRepositoryRef = ProviderRef<TodosRepository>;
String _$todosHash() => r'47248afe3cffcdfb55f261f9de6830908fc2f412';

/// See also [todos].
@ProviderFor(todos)
final todosProvider = AutoDisposeStreamProvider<List<Todo>>.internal(
  todos,
  name: r'todosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodosRef = AutoDisposeStreamProviderRef<List<Todo>>;
String _$todoNotifierHash() => r'a8e30d5aee1c581e9b2d26d2f2e896b0c7ac405e';

/// See also [TodoNotifier].
@ProviderFor(TodoNotifier)
final todoNotifierProvider =
    AutoDisposeAsyncNotifierProvider<TodoNotifier, void>.internal(
      TodoNotifier.new,
      name: r'todoNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todoNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodoNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
