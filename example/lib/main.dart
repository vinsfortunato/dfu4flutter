import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:dfu4flutter/dfu4flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      final device = await Dfu.getDevices().then(
        (devices) => devices
            .where(
              (device) => device.alternateSetting == 0,
            )
            .first,
      );

      File firmwareFile =
          File('C:\\Users\\vinsf\\Desktop\\sense8-firmware-0.0.1.bin');

      await device.download(
        firmwareFile,
        useDfuse: true,
        dfuseAddress: 0x08000000,
        dfuseLeave: false,
        onProgress: (progress) {
          print(
              '${progress.step}/${progress.totalSteps} ${progress.stepName}: ${(progress.stepProgress * 100).toInt()}%');
        },
      );

      platformVersion = '1';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
