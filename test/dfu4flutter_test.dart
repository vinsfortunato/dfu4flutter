import 'package:dfu4flutter/dfu4flutter.dart';

void main() async {
  final devices = await Dfu.getDevices();
  for (final device in devices) {
    print(device);
  }
}
