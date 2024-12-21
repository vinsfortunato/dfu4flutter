import 'package:flutter/material.dart';
import 'package:dfu4flutter/dfu4flutter.dart';

void main() {
  runApp(DfuExampleApp());
}

class DfuExampleApp extends StatefulWidget {
  const DfuExampleApp({super.key});

  @override
  _DfuExampleAppState createState() => _DfuExampleAppState();
}

class _DfuExampleAppState extends State<DfuExampleApp> {
  List<DfuDevice> _devices = [];

  @override
  void initState() {
    super.initState();
    loadDevices();
  }

  Future<void> loadDevices() async {
    List<DfuDevice> devices = await Dfu.getDevices();

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _devices = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_devices[index].name),
                    subtitle: Text(_devices[index].path),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
