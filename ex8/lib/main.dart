import 'package:camera/camera.dart';
import 'package:ex8/views/picture_screen.dart';
import 'package:ex8/views/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'view_model/initialized_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InitializedViewModel>(
        create: (context) => InitializedViewModel(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: "/camera",
          routes: {
            "/camera": (context) => PictureScreen(camera: camera),
            "/gallery": (context) => const GalleryScreen()
          },
        ));
  }
}
