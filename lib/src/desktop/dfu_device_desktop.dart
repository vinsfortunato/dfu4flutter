import 'dart:convert';
import 'dart:io';

import '../dfu_device.dart';
import '../dfu_progress_update.dart';

class DfuDeviceDesktop extends DfuDevice {
  DfuDeviceDesktop(
    this._executable, {
    required int vendorId,
    required int productId,
    required int bcdDevice,
    required int deviceNumber,
    required int configuration,
    required int interface,
    required String path,
    required int alternateSetting,
    required String name,
    required String serial,
  })  : _vendorId = vendorId,
        _productId = productId,
        _bcdDevice = bcdDevice,
        _deviceNumber = deviceNumber,
        _configuration = configuration,
        _interface = interface,
        _path = path,
        _alternateSetting = alternateSetting,
        _name = name,
        _serial = serial;

  final String _executable;

  final int _vendorId;
  final int _productId;
  final int _bcdDevice;
  final int _deviceNumber;
  final int _configuration;
  final int _interface;
  final String _path;
  final int _alternateSetting;
  final String _name;
  final String _serial;

  @override
  int get vendorId => _vendorId;

  @override
  int get productId => _productId;

  @override
  int get bcdDevice => _bcdDevice;

  @override
  int get deviceNumber => _deviceNumber;

  @override
  int get configuration => _configuration;

  @override
  int get interface => _interface;

  @override
  String get path => _path;

  @override
  int get alternateSetting => _alternateSetting;

  @override
  String get name => _name;

  @override
  String get serial => _serial;

  @override
  Future<void> download(
    File file, {
    bool useDfuse = false,
    int dfuseAddress = 0x08000000,
    bool dfuseLeave = false,
    void Function(DfuProgressUpdate)? onProgress,
  }) async {
    if (!await file.exists()) {
      throw FileSystemException('File does not exist: ${file.path}');
    }

    final process = await Process.start(
      _executable,
      _buildDownloadArgs(
        file,
        useDfuse: useDfuse,
        dfuseAddress: dfuseAddress,
        dfuseLeave: dfuseLeave,
      ),
    );

    const totalSteps = 3;

    var lastUpdate = DfuProgressUpdate(
      step: 0,
      stepName: 'Init',
      stepMessage: 'Starting dfu-util...',
      stepProgress: -1.0,
      totalSteps: totalSteps,
    );

    // Listen to the stdout stream and parse progress updates
    process.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(
      (line) {
        // Match progress lines
        final match = RegExp(r'(\w+)\s+\[.*\]\s+(\d+)%').firstMatch(line);
        if (match != null) {
          final step = match.group(1) ?? '';
          final progress = double.parse(match.group(2) ?? '-1.0');

          if (step.contains('Erase')) {
            lastUpdate = DfuProgressUpdate(
              step: 1,
              stepName: 'Erase',
              stepMessage: line,
              stepProgress: progress / 100,
              totalSteps: totalSteps,
            );
          } else if (step.contains('Download')) {
            lastUpdate = DfuProgressUpdate(
              step: 2,
              stepName: 'Download',
              stepMessage: line,
              stepProgress: progress / 100,
              totalSteps: totalSteps,
            );
          }
        } else {
          lastUpdate = lastUpdate.copyWith(stepMessage: line);
        }

        onProgress?.call(lastUpdate);
      },
    );

    final exitCode = await process.exitCode;

    if (exitCode != 0) {
      throw Exception('Failed to download firmware to device. '
          'Error: ${process.stderr}');
    }

    if (!lastUpdate.stepMessage.contains('File downloaded successfully')) {
      throw Exception('Failed to download firmware to device.');
    }
  }

  List<String> _buildDownloadArgs(
    File file, {
    bool useDfuse = false,
    int dfuseAddress = 0x08000000,
    bool dfuseLeave = false,
  }) {
    final args = <String>[];

    args.addAll([
      '--device',
      ',${_vendorId.toRadixString(16)}:${_productId.toRadixString(16)}',
      '--cfg',
      '$_configuration',
      '--intf',
      '$_interface',
      '--alt',
      '$_alternateSetting',
    ]);

    if (useDfuse) {
      var addrString = '0x${dfuseAddress.toRadixString(16).padLeft(8, '0')}';
      var modsString = '';

      if (dfuseLeave) {
        modsString += ':leave';
      }

      args.addAll(['--dfuse-address', '$addrString$modsString']);
    }

    args.addAll(['--download', file.path]);

    return args;
  }

  @override
  Future<void> upload(
    File file, {
    void Function(DfuProgressUpdate)? onProgress,
  }) {
    throw UnimplementedError();
  }
}
