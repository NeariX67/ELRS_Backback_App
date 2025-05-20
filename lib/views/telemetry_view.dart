import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../backend/data_controllers/data_controller.dart';
import '../backend/telemetry_controller.dart';
import 'app_scaffold.dart';
import 'telemetry_widgets/altitude_vario_widget.dart';
import 'telemetry_widgets/attitude_widget.dart';
import 'telemetry_widgets/battery_widget.dart';
import 'telemetry_widgets/down_link_statistics_widget.dart';
import 'telemetry_widgets/location_widget.dart';
import 'telemetry_widgets/up_link_statistics_widget.dart';
import 'telemetry_widgets/video_transmitter_widget.dart';

class TelemetryView extends StatelessWidget {
  final TelemetryController telemetryController;
  final DataController Function() controllerBuilder;

  const TelemetryView({
    super.key,
    required this.controllerBuilder,
    required this.telemetryController,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: GetBuilder(
        init: controllerBuilder(),
        builder:
            (controller) => ListenableBuilder(
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
                      LocationWidget(
                        telemetryController.telemetry.uavLocation!,
                      ),
                    if (telemetryController.telemetry.batterySensor != null)
                      BatteryWidget(
                        telemetryController.telemetry.batterySensor!,
                      ),
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
            ),
      ),
    );
  }
}
