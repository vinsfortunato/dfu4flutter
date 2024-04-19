import 'package:flutter_test/flutter_test.dart';
import 'package:dfu4flutter/dfu4flutter.dart';
import 'package:dfu4flutter/src/dfu_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDfu4flutterPlatform
    with MockPlatformInterfaceMixin
    implements DfuPlatform {
  @override
  Future<List<DfuDevice>> getDevices() {
    throw UnimplementedError();
  }
}

void main() {
  final DfuPlatform initialPlatform = DfuPlatform.instance;
}
