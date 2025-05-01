import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'backend/log.dart';
import 'views/app_scaffold.dart';
import 'views/serial_selector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    Logger.logLevel = LogLevel.verbose;
  } else if (GetPlatform.isWeb) {
    Logger.logLevel = LogLevel.warning;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      title: 'ELRS Backpack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AppScaffold(child: const SerialSelector()),
    );
  }
}
