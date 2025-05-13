import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/communication_model.dart';
import '../backend/demo_controller.dart';
import '../backend/telemetry_controller.dart';

class TelemetryView extends StatelessWidget {
  final String selectedPort;

  final TelemetryController telemetryController = TelemetryController();

  TelemetryView({super.key, required this.selectedPort});

  @override
  Widget build(BuildContext context) {
    // return GridView(gridDelegate: gridDelegate);
    return GetBuilder(
      // init: SerialController(
      init: DemoController(
        // selectedPort: selectedPort,
        onDataReceived: _onDataReceived,
      ),
      builder: (context) {
        return Text(selectedPort);
      },
    );
  }

  void _onDataReceived(Map<String, dynamic> json) {
    CommunicationModel communicationModel = CommunicationModel.fromJson(json);

    if (communicationModel.event == 'telemetry') {
      if (communicationModel.data == null) {
        print('No data received');
        return;
      }
      print("Received");
      telemetryController.onTelemetryDataReceived(communicationModel.data!);
    } else {
      // Handle other events if needed
      print('Received event: ${communicationModel.event}');
    }
  }
}
