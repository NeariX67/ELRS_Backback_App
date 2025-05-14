import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';

class AltitudeVarioWidget extends StatelessWidget {
  final AltitudeVario altitudeVario;

  const AltitudeVarioWidget(this.altitudeVario, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListenableBuilder(
        listenable: altitudeVario,
        builder:
            (context, child) => Column(
              children: [
                Text('Altitude: ${altitudeVario.altitude}'),
                Text('Vario: ${altitudeVario.varioSpeed}'),
              ],
            ),
      ),
    );
  }
}
