import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationDialog extends StatefulWidget {
  const LocationDialog({Key? key}) : super(key: key);

  @override
  State<LocationDialog> createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  LocationData? location;

  @override
  void initState() {
    _getLocation().then((value) => setState(() => location = value));
    super.initState();
  }

  Future<LocationData?> _getLocation() async {
    Location location = Location();

    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Your location"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Latitude: ${location?.latitude ?? 0.0}"),
          Text("Longitude: ${location?.longitude ?? 0.0}"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Dismiss"),
        ),
      ],
    );
  }
}
