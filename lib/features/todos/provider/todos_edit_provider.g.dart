// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_edit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editTodoHash() => r'0f5896789d677d55e2d379d12afbca47fc1e8e37';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$EditTodo extends BuildlessAutoDisposeNotifier<EditTodoState> {
  late final Todo? initialTodo;

  EditTodoState build({Todo? initialTodo});
}

/// See also [EditTodo].
@ProviderFor(EditTodo)
const editTodoProvider = EditTodoFamily();

/// See also [EditTodo].
class EditTodoFamily extends Family<EditTodoState> {
  /// See also [EditTodo].
  const EditTodoFamily();

  /// See also [EditTodo].
  EditTodoProvider call({Todo? initialTodo}) {
    return EditTodoProvider(initialTodo: initialTodo);
  }

  @override
  EditTodoProvider getProviderOverride(covariant EditTodoProvider provider) {
    return call(initialTodo: provider.initialTodo);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editTodoProvider';
}

/// See also [EditTodo].
class EditTodoProvider
    extends AutoDisposeNotifierProviderImpl<EditTodo, EditTodoState> {
  /// See also [EditTodo].
  EditTodoProvider({Todo? initialTodo})
    : this._internal(
        () => EditTodo()..initialTodo = initialTodo,
        from: editTodoProvider,
        name: r'editTodoProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$editTodoHash,
        dependencies: EditTodoFamily._dependencies,
        allTransitiveDependencies: EditTodoFamily._allTransitiveDependencies,
        initialTodo: initialTodo,
      );

  EditTodoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialTodo,
  }) : super.internal();

  final Todo? initialTodo;

  @override
  EditTodoState runNotifierBuild(covariant EditTodo notifier) {
    return notifier.build(initialTodo: initialTodo);
  }

  @override
  Override overrideWith(EditTodo Function() create) {
    return ProviderOverride(
      origin: this,
      override: EditTodoProvider._internal(
        () => create()..initialTodo = initialTodo,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialTodo: initialTodo,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<EditTodo, EditTodoState> createElement() {
    return _EditTodoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditTodoProvider && other.initialTodo == initialTodo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialTodo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EditTodoRef on AutoDisposeNotifierProviderRef<EditTodoState> {
  /// The parameter `initialTodo` of this provider.
  Todo? get initialTodo;
}

class _EditTodoProviderElement
    extends AutoDisposeNotifierProviderElement<EditTodo, EditTodoState>
    with EditTodoRef {
  _EditTodoProviderElement(super.provider);

  @override
  Todo? get initialTodo => (origin as EditTodoProvider).initialTodo;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
