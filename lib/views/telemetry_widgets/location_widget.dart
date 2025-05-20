import 'dart:convert';

import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class LocationWidget extends StatefulWidget {
  final Location location;

  const LocationWidget(this.location, {super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final MapController mapController = MapController();

  String? googleMapsToken;
  final String googleMapsApiToken = '';

  late final MapOptions _mapOptions = MapOptions(
    initialCenter: LatLng(widget.location.latitude, widget.location.longitude),
    initialZoom: 17,
    maxZoom: 20,
    minZoom: 10,
  );

  @override
  void initState() {
    super.initState();
    widget.location.addListener(_positionChanged);
  }

  @override
  void dispose() {
    widget.location.removeListener(_positionChanged);
    super.dispose();
  }

  void _positionChanged() {
    mapController.move(
      LatLng(widget.location.latitude, widget.location.longitude),
      mapController.camera.zoom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListenableBuilder(
        listenable: widget.location,
        builder: (context, _) {
          return FutureBuilder(
            future: _getGoogleMapsToken(),
            builder: (_, token) {
              if (!token.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return FlutterMap(
                mapController: mapController,
                options: _mapOptions,
                children: [
                  TileLayer(
                    // urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    urlTemplate:
                        'https://tile.googleapis.com/v1/2dtiles/{z}/{x}/{y}?session=${token.data!}&key=$googleMapsApiToken',
                    userAgentPackageName: 'com.kgdevelopment.smartbmslink',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(
                          widget.location.latitude,
                          widget.location.longitude,
                        ),
                        width: 40,
                        height: 40,
                        child: Transform.rotate(
                          angle: (widget.location.heading! * (3.14 / 180)),
                          child: Icon(
                            Icons.airplanemode_active,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<String?> _getGoogleMapsToken() async {
    if (googleMapsToken != null) {
      return googleMapsToken;
    }

    final url = Uri.parse(
      'https://tile.googleapis.com/v1/createSession?key=$googleMapsApiToken',
    );
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: '''
      {
        "mapType": "satellite",
        "language": "de",
        "region": "DE"
      }
      ''',
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      googleMapsToken = data['session'];
      return data['session'];
    }
    print('Error: ${response.statusCode}');
    print('Response: ${response.body}');
    return null;
  }
}
