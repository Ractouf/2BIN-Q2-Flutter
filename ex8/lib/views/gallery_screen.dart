import 'dart:io';
import 'package:ex8/views/display_picture_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallerie"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<Widget>(
        future: _gallery(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }

  Future<Widget> _gallery(BuildContext context) async {
    if (!kIsWeb) {
      return FutureBuilder<List<File>>(
        future: _getImages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                            imagePath: snapshot.data![index].path),
                      ),
                    );
                  },
                  child: Image.file(
                    snapshot.data![index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    } else {
      return FutureBuilder<Uint8List?>(
        future: _filePicker(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Image.memory(snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      );
    }
  }

  Future<List<File>> _getImages() async {
    Directory? directory = await getExternalStorageDirectory();
    Directory imagesDirectory = Directory('${directory?.path}');
    List<File> images = await imagesDirectory
        .list()
        .where(
            (file) => file.path.endsWith('.jpg') || file.path.endsWith('.png'))
        .map((file) => File(file.path))
        .toList();
    return images;
  }

  Future<Uint8List?> _filePicker(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return result.files.single.bytes!;
    } else {
      Navigator.pop(context);
    }
    return null;
  }
}
