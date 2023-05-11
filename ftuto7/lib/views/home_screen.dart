import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:ftuto7/views/location_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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

    return Scaffold(
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
                    message: "Test SMS",
                    recipients: ["0456555321"],
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
                builder: (context) => const LocationDialog(),
              ),
              child: const Text("Retrieve location"),
            ),
          ],
        ),
      ),
    );
  }
}
