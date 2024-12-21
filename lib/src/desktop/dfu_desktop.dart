import 'dart:io';

import '../dfu_platform_interface.dart';
import '../dfu_device.dart';
import 'dfu_device_desktop.dart';

class DfuWindows extends _DfuDesktop {
  DfuWindows() : super('dfu-util-static');

  static registerWith() {
    DfuPlatform.instance = DfuWindows();
  }
}

class DfuMacos extends _DfuDesktop {
  DfuMacos() : super('dfu-util');

  static registerWith() {
    DfuPlatform.instance = DfuMacos();
  }
}

class DfuLinux extends _DfuDesktop {
  DfuLinux() : super('dfu-util');

  static registerWith() {
    DfuPlatform.instance = DfuLinux();
  }
}

class _DfuDesktop extends DfuPlatform {
  _DfuDesktop(this._executable);

  final String _executable;

  static final _listRegex = RegExp(
      r'Found DFU: '
      r'\[(\w{4}):(\w{4})\] ver=(\w{4}), devnum=(\d+), '
      r'cfg=(\d+), intf=(\d+), path="([^"]*)", alt=(\d+), '
      r'name="([^"]*)", serial="([^"]*)"',
      multiLine: true);

  @override
  Future<List<DfuDevice>> getDevices() async {
    final result = await Process.run(_executable, ['-l']);

    if (result.exitCode != 0) {
      throw Exception('Failed to get device list. ${result.stderr}');
    }

    final devices = <DfuDevice>[];

    for (final match in _listRegex.allMatches(result.stdout.toString())) {
      devices.add(DfuDeviceDesktop(
        _executable,
        vendorId: int.parse(match.group(1)!, radix: 16),
        productId: int.parse(match.group(2)!, radix: 16),
        bcdDevice: int.parse(match.group(3)!, radix: 16),
        deviceNumber: int.parse(match.group(4)!),
        configuration: int.parse(match.group(5)!),
        interface: int.parse(match.group(6)!),
        path: match.group(7)!,
        alternateSetting: int.parse(match.group(8)!),
        name: match.group(9)!,
        serial: match.group(10)!,
      ));
    }

    return devices;
  }
}
