import 'package:camera/camera.dart';
import 'package:ex8/view_model/initialized_view_model.dart';
import 'package:flutter/material.dart';
import 'display_picture_screen.dart';
import 'package:provider/provider.dart';

class PictureScreen extends StatefulWidget {
  const PictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  PictureScreenState createState() => PictureScreenState();
}

class PictureScreenState extends State<PictureScreen> {
  bool isInitialised = false;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InitializedViewModel>(
        builder: (context, viewModel, child) => Scaffold(
              appBar: AppBar(
                title: const Text("Photographie"),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.pushNamed(context, "/gallery"),
                      icon: const Icon(Icons.dashboard))
                ],
              ),
              body: Column(
                children: [
                  FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (viewModel.initialized &&
                          snapshot.connectionState == ConnectionState.done) {
                        return CameraPreview(_controller);
                      } else if (!viewModel.initialized) {
                        return const Center(
                            child: Text("Veuillez redémarrer de flux vidéo"));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: _controller.value.isPreviewPaused
                              ? const Icon(Icons.play_arrow)
                              : const Icon(Icons.pause),
                          color: Colors.blue,
                          onPressed: () => onPausePreviewButtonPressed()),
                      IconButton(
                          icon: !viewModel.initialized
                              ? const Icon(Icons.play_arrow)
                              : const Icon(Icons.pause),
                          color: Colors.blue,
                          onPressed: () => stopFluxVideo()),
                    ],
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  try {
                    await _initializeControllerFuture;
                    final image = await _controller.takePicture();

                    if (!mounted) return;

                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            DisplayPictureScreen(imagePath: image.path),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
            ));
  }

  stopFluxVideo() {
    final viewModel = Provider.of<InitializedViewModel>(context, listen: false);
    if (viewModel.initialized) {
      _controller.dispose();
    } else {
      _controller = CameraController(
        widget.camera,
        ResolutionPreset.medium,
      );

      _initializeControllerFuture = _controller.initialize();
    }

    viewModel.switchInitialized();
  }

  Future<void> onPausePreviewButtonPressed() async {
    final CameraController cameraController = _controller;

    if (!cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isPreviewPaused) {
      await cameraController.resumePreview();
    } else {
      await cameraController.pausePreview();
    }

    if (mounted) {
      setState(() {});
    }
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
