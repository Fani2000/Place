import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:places/models/Place.dart';
import 'package:places/helpers/db_helper.dart';

class GreatPlace with ChangeNotifier {
  List<Place> _items = [
    // Place(
    //   id: "dkaf12903430",
    //   title: 'test',
    //   image: File(''),
    //   location: PlaceLocation(
    //     address: "test",
    //     latitude: 2345.9,
    //     longitude: -90.90394,
    //   ),
    // )
  ];

  UnmodifiableListView<Place> get items => UnmodifiableListView(_items);

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: items.length + 1,
      image: image,
      title: title,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'places',
      {
        "id": newPlace.id,
        "title": newPlace.title,
        "image": newPlace.image.path
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.getData('places');

    _items = data
        .map(
          (item) => Place(
            id: item["id"],
            title: item['title'],
            location: null,
            image: File(item['image']),
          ),
        )
        .toList();
    // print(_items);
    notifyListeners();
  }
}
