import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:places/screens/Map.dart';
import 'package:provider/provider.dart';
import 'package:places/providers/great_places.dart';

class PlacesDetails extends StatelessWidget {
  static String routeName = '/details';
  const PlacesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id =
        (ModalRoute.of(context)!.settings.arguments as Map<String, int>)['id'];
    final selectedPlace = context.read<GreatPlace>().fndById(id!);
    // print(selectedPlace.location.latitude);
    // print(selectedPlace.location.longitude);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details for ${selectedPlace.title}',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.file(
              fit: BoxFit.cover,
              selectedPlace.image,
            ),
          ),
          Expanded(
            child: MapScreen(
              mapOptions: MapOptions(
                center: LatLng(
                  selectedPlace.location.latitude,
                  selectedPlace.location.longitude,
                ),
                zoom: 12,
              ),
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  rotate: true,
                  point: LatLng(
                    selectedPlace.location.latitude,
                    selectedPlace.location.longitude,
                  ),
                  builder: (ctx) => const Icon(
                    Icons.location_pin,
                    color: Colors.blue,
                    size: 60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
