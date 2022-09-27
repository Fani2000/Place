import 'package:flutter/material.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/screens/Map.dart';
import 'package:places/screens/add_places_screen.dart';
import 'package:places/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GreatPlace(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PlacesListScreen(),
      routes: {
        AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
      },
    );
  }
}
