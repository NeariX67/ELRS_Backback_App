import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';

class RawLocationWidget extends StatelessWidget {
  final UavLocation location;
  const RawLocationWidget(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListenableBuilder(
        listenable: location,
        builder:
            (context, child) => Column(
              children: [
                Text('Latitude: ${location.latitude}'),
                Text('Longitude: ${location.longitude}'),
                Text('Altitude: ${location.altitude}'),
                Text('Heading: ${location.heading}'),
                Text('Speed: ${location.groundSpeed}'),
                Text('GPS Satellites: ${location.gpsSatellites}'),
              ],
            ),
      ),
    );
  }
}
