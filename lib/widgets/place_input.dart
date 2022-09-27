import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:path/path.dart';
import 'package:places/screens/Map.dart';

class LocationInput extends StatefulWidget {
  final Function selectedLocation;
  const LocationInput({
    Key? key,
    required this.selectedLocation,
  }) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // String? _previewImageUrl;
  final _mapController = MapController();
  double lat = 0.0, lng = 0.0;
  bool isCurrent = false;
  MapOptions? mapOptions;
  List<Marker>? markers;

  void showMarker(double lat, double lng) {
    markers = [
      Marker(
        width: 80.0,
        height: 80.0,
        rotate: true,
        point: LatLng(lat, lng),
        builder: (ctx) => const Icon(
          Icons.location_pin,
          color: Colors.blue,
          size: 60,
        ),
      ),
    ];
  }

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    // print(locData.latitude);
    // print(locData.longitude);
    setState(
      () {
        isCurrent = true;
        lat = locData.latitude!;
        lng = locData.longitude!;

        mapOptions = MapOptions(
          center: LatLng(lat, lng),
          zoom: 12,
        );
        showMarker(lat, lng);
        widget.selectedLocation(lat, lng);
      },
    );
  }

  Future<void> _selectFromMap() async {
    final locData = await Location().getLocation();
    setState(() {
      isCurrent = true;
      lat = locData.latitude!;
      lng = locData.longitude!;

      mapOptions = MapOptions(
        controller: _mapController,
        center: LatLng(lat, lng),
        zoom: 12,
        onTap: (tapPosition, point) => {
          lat = point.latitude,
          lng = point.longitude,
          // print('Select From Map - $lat:$lng'),
          // _mapController.move(LatLng(lat, lng), 12),
          setState(
            () {
              showMarker(lat, lng);
              widget.selectedLocation(lat, lng);
            },
          ),
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: isCurrent == false
              ? const Text(
                  "No Location Chosen",
                  textAlign: TextAlign.center,
                )
              : MapScreen(
                  mapOptions: mapOptions!,
                  markers: markers ?? [],
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectFromMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}
