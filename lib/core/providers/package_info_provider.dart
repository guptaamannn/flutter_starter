import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'package_info_provider.g.dart';

@riverpod
Future<PackageInfo> packageinfo(Ref ref) async {
  return await PackageInfo.fromPlatform();
}
