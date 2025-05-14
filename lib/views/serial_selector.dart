import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';

import 'app_scaffold.dart';
import 'telemetry_view.dart';

class SerialSelector extends StatefulWidget {
  const SerialSelector({super.key});

  @override
  State<SerialSelector> createState() => _SerialSelectorState();
}

class _SerialSelectorState extends State<SerialSelector> {
  String? selectedPort;

  List<String> serialPorts = SerialPort.availablePorts;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: DropdownButton<String>(
                  value: selectedPort,
                  hint: Text("Port".tr),
                  alignment: Alignment.center,
                  enableFeedback: true,
                  isExpanded: true,
                  dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
                  items:
                      serialPorts
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              alignment: Alignment.center,
                              child: Text(
                                e,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (port) {
                    setState(() {
                      selectedPort = port;
                    });
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    serialPorts = SerialPort.availablePorts;
                  });
                },
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
          ElevatedButton(
            onPressed:
                selectedPort != null
                    ? () {
                      Get.to(
                        () => AppScaffold(
                          child: TelemetryView(selectedPort: selectedPort!),
                        ),
                      );
                    }
                    : null,
            child: Text("Open".tr),
          ),
        ],
      ),
    );
  }
}
