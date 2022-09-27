import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/widgets/image_input.dart';
import 'package:places/widgets/place_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routeName = '/addplace';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  File? pickedImage;
  double? lat, lng;

  void _selectImage(File? _pickedImage) {
    pickedImage = _pickedImage;
  }

  void _savePlace(context) async {
    if (_titleController.text.isEmpty ||
        pickedImage == null ||
        lat == null ||
        lng == null) {
      await Fluttertoast.showToast(
        msg: "Please Fill all the fields!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    Provider.of<GreatPlace>(context, listen: false).addPlace(
      _titleController.text,
      pickedImage!,
      lat!,
      lng!,
    );

    Navigator.of(context).pop();
  }

  void _selectPlace(double _lat, double _lng) {
    print('Location: $_lat:$_lng');
    lat = _lat;
    lng = _lng;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      label: Text("address"),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ImageInput(
                    selectImage: _selectImage,
                  ),
                  const SizedBox(height: 20.0),
                  LocationInput(
                    selectedLocation: _selectPlace,
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(elevation: 0),
            onPressed: () => _savePlace(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
          ),
        ],
      ),
    );
  }
}
