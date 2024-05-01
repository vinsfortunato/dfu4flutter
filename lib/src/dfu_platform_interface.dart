import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dfu_device.dart';

abstract class DfuPlatform extends PlatformInterface {
  DfuPlatform() : super(token: _token);

  static final Object _token = Object();

  static late DfuPlatform _instance;

  /// The default instance of [DfuPlatform] to use.
  static DfuPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DfuPlatform] when
  /// they register themselves.
  static set instance(DfuPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<DfuDevice>> getDevices();
}
