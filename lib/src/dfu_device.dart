import 'dart:io';

import 'package:dfu4flutter/dfu4flutter.dart';

/// Represents a device that can be updated using the DFU protocol.
abstract class DfuDevice {
  int get vendorId;
  int get productId;
  int get bcdDevice;
  int get deviceNumber;
  int get configuration;
  int get interface;
  String get path;
  int get alternateSetting;
  String get name;
  String get serial;

  /// Write firmware from [file] into device
  ///
  /// [useDfuse] is used to determine whether to use DfuSe protocol or not.
  /// When using DfuSe protocol, the [dfuseAddress] is the address to write
  /// the firmware to and [dfuseLeave] is used to instruct the device to leave
  /// the DfuSe mode after writing the firmware.
  ///
  /// [onProgress] is a callback that is called when the progress of the
  /// operation changes.
  ///
  /// Returns a [Future] that completes when the firmware is written.
  Future<void> download(
    File file, {
    bool useDfuse = false,
    int dfuseAddress = 0x08000000,
    bool dfuseLeave = false,
    void Function(DfuProgressUpdate)? onProgress,
  });

  /// Read firmware from device into [file].
  ///
  /// [onProgress] is a callback that is called when the progress of the
  /// operation changes.
  ///
  /// Returns a [Future] that completes when the firmware is read.
  Future<void> upload(
    File file, {
    void Function(DfuProgressUpdate)? onProgress,
  });

  @override
  String toString() {
    return 'DfuDevice{'
        'vendorId: ${vendorId.toRadixString(16).padLeft(4, '0')}, '
        'productId: ${productId.toRadixString(16).padLeft(4, '0')}, '
        'bcdDevice: ${bcdDevice.toRadixString(16).padLeft(4, '0')}, '
        'deviceNumber: $deviceNumber, '
        'configuration: $configuration, '
        'interface: $interface, '
        'path: "$path", '
        'alternateSetting: $alternateSetting, '
        'name: "$name", '
        'serial: "$serial"'
        '}';
  }
}
