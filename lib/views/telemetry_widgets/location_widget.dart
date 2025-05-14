import 'package:elrs_telem/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationWidget extends StatefulWidget {
  final Location location;

  const LocationWidget(this.location, {super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final MapController mapController = MapController();

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
    bool success = mapController.move(
      LatLng(widget.location.latitude, widget.location.longitude),
      mapController.camera.zoom,
    );
    print('Map moved: $success');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListenableBuilder(
        listenable: widget.location,
        builder: (context, _) {
          return FlutterMap(
            mapController: mapController,
            options: _mapOptions,
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                    child: Icon(
                      Icons.airplanemode_active,
                      size: 40,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
