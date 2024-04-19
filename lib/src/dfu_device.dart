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
