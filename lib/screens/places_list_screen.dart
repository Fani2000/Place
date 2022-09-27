import 'package:flutter/material.dart';
import 'package:places/models/Place.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/screens/add_places_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<GreatPlace>().fetchAndSetPlaces();
    final List<Place> items = context.watch<GreatPlace>().items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: items.isNotEmpty
          ? ListView.builder(
              itemBuilder: (ctx, i) => ListTile(
                title: Text(items[i].title),
                leading: CircleAvatar(
                  backgroundImage: FileImage(items[i].image),
                ),
                onTap: () {
                  //TODO: GO to detilas screen
                },
              ),
              itemCount: items.length,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
