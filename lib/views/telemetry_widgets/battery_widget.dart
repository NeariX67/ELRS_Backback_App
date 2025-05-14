import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';

class BatteryWidget extends StatelessWidget {
  final BatterySensor batterySensor;
  const BatteryWidget(this.batterySensor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListenableBuilder(
        listenable: batterySensor,
        builder:
            (context, child) => Column(
              children: [
                const Text('Battery'),
                const SizedBox(height: 10),
                Text(
                  'Voltage: ${batterySensor.voltage.toStringAsFixed(2)} V',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Current: ${batterySensor.current.toStringAsFixed(2)} A',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Power: ${batterySensor.power.toStringAsFixed(2)} W',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Capacity: ${batterySensor.capacity} mAh',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Percentage: ${batterySensor.percentage} %',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
      ),
    );
  }
}
