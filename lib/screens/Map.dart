import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  // final List<double> location;
  final MapOptions mapOptions;
  // final Function? onTap;
  final List<Marker>? markers;

  const MapScreen({
    Key? key,
    required this.mapOptions,
    // required this.onTap,
    this.markers,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      // mapController: _mapController,
      options: widget.mapOptions,
      // options: MapOptions(
      //   center: LatLng(
      //     widget.location[0],
      //     widget.location[1],
      //   ),
      //   zoom: 9.2,
      // ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(markers: widget.markers!)
        // MarkerLayerOptions(markers: [
        //   Marker(
        //     width: 80.0,
        //     height: 80.0,
        //     rotate: true,
        //     point: LatLng(
        //       widget.location[0],
        //       widget.location[1],
        //     ),
        //     builder: (ctx) => const Icon(
        //       Icons.location_pin,
        //       color: Colors.blue,
        //       size: 60,
        //     ),
        //   ),
        // ])
      ],
    );
  }
}
