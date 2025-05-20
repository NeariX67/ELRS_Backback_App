import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
                Text('Altitude: ${location.altitude} m'),
                Text('Heading: ${location.heading} °'),
                Text('Speed: ${location.groundSpeed} km/h'),
                Text('GPS Satellites: ${location.gpsSatellites}'),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    launchUrlString(
                      "https://www.google.com/maps/place/${location.latitude},${location.longitude}",
                    );
                  },
                  child: Text("Open Google Maps"),
                ),
              ],
            ),
      ),
    );
  }
}
