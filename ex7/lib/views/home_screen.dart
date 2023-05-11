import 'dart:io';
import 'package:ex7/views/phones_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ex7/views/emergency_dialog.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../view_model/emergency_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    String platform;

    if (kIsWeb) {
      platform = "Web";
    } else if (Platform.isAndroid) {
      platform = "Android";
    } else if (Platform.isIOS) {
      platform = "iOS";
    } else if (Platform.isWindows) {
      platform = "Windows";
    } else if (Platform.isMacOS) {
      platform = "macOS";
    } else if (Platform.isLinux) {
      platform = "Linux";
    } else {
      platform = "Unknown";
    }

    return Consumer<EmergencyViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(title: const Text("Tutoriel 7")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Hello from $platform!"),
              const SizedBox(height: 16),
              if (["Web", "Android", "iOS"].contains(platform))
                ElevatedButton(
                  onPressed: () async {
                    await sendSMS(
                      message: viewModel.sosBase.replaceAll("@loc",
                          '(lat : ${location?.latitude ?? 0.0}, lon : ${location?.longitude ?? 0.0})'),
                      recipients: viewModel.phonesSos,
                    );
                  },
                  child: const Text("Send SMS"),
                )
              else
                const Text("Your platform doesn't allow you to send SMS…"),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const EmergencyDialog(),
                ),
                child: const Text("Change SOS message"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const PhonesDialog(),
                ),
                child: const Text("Manage SOS recipients"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
