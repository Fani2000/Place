import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:places/models/Place.dart';

class GreatPlace with ChangeNotifier {
  final List<Place> _items = [
    Place(
      id: "dkaf12903430",
      title: 'test',
      image: File(''),
      location: PlaceLocation(
        address: "test",
        latitude: 2345.9,
        longitude: -90.90394,
      ),
    )
  ];

  UnmodifiableListView<Place> get items => UnmodifiableListView(_items);
}
