import 'dart:io';
import '../dfu_device.dart';

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
}
