import 'package:example/remote_config/remote_config.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await RemoteConfig.instance.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(child: Column(children: [Text('minimum_build: ${RemoteConfig.values.minimumBuild}'), Text('latest_build: ${RemoteConfig.values.latestBuild}')])),
        ),
      ),
    );
  }
}
