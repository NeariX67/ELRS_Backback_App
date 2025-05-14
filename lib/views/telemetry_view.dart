import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/communication_model.dart';
import '../backend/demo_controller.dart';
import '../backend/serial_controller.dart';
import '../backend/telemetry_controller.dart';
import 'telemetry_widgets/altitude_vario_widget.dart';
import 'telemetry_widgets/attitude_widget.dart';
import 'telemetry_widgets/battery_widget.dart';
import 'telemetry_widgets/down_link_statistics_widget.dart';
import 'telemetry_widgets/location_widget.dart';
import 'telemetry_widgets/up_link_statistics_widget.dart';
import 'telemetry_widgets/video_transmitter_widget.dart';

class TelemetryView extends StatelessWidget {
  final String selectedPort;

  final TelemetryController telemetryController = TelemetryController();

  TelemetryView({super.key, required this.selectedPort});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SerialController(
        // init: DemoController(
        selectedPort: selectedPort,
        onDataReceived: _onDataReceived,
      ),
      builder: (controller) {
        return ListenableBuilder(
          listenable: telemetryController.telemetry,
          builder: (context, _) {
            return GridView.extent(
              maxCrossAxisExtent: 316,
              childAspectRatio:
                  MediaQuery.of(context).size.width < 372 ? 2.1 : 1,
              mainAxisSpacing: 0,
              crossAxisSpacing: 15,
              children: [
                if (telemetryController.telemetry.uavLocation != null)
                  LocationWidget(telemetryController.telemetry.uavLocation!),
                if (telemetryController.telemetry.batterySensor != null)
                  BatteryWidget(telemetryController.telemetry.batterySensor!),
                if (telemetryController.telemetry.linkStatistics != null)
                  UpLinkStatisticsWidget(
                    telemetryController.telemetry.linkStatistics!,
                  ),
                if (telemetryController.telemetry.linkStatistics != null)
                  DownLinkStatisticsWidget(
                    telemetryController.telemetry.linkStatistics!,
                  ),
                if (telemetryController.telemetry.attitude != null)
                  AttitudeWidget(telemetryController.telemetry.attitude!),
                if (telemetryController.telemetry.altitudeVario != null)
                  AltitudeVarioWidget(
                    telemetryController.telemetry.altitudeVario!,
                  ),
                if (telemetryController.telemetry.videoTransmitter != null)
                  VideoTransmitterWidget(
                    telemetryController.telemetry.videoTransmitter!,
                  ),

                // ..._buildTelemetryWidgets(),
              ],
            );
          },
        );
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
