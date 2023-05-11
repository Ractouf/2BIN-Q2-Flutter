import 'dart:io';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Magnifique image !")),
        body: kIsWeb ? Image.network(imagePath) : Image.file(File(imagePath)),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            kIsWeb
                ? await FileSaver.instance.saveFile(
                    name: "${DateTime.now()}.jpg", link: imagePath)
                : await FileSaver.instance.saveFile(
                    name: "${DateTime.now()}",
                    file: File(imagePath),
                    filePath: imagePath,
                    ext: "jpg");
            Navigator.pop(context);
          },
          child: const Icon(Icons.save),
        ));
  }
}
