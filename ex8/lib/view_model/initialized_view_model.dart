import 'package:flutter/material.dart';

class InitializedViewModel extends ChangeNotifier {
  bool _initialized = true;

  bool get initialized => _initialized;

  void switchInitialized() {
    _initialized = !_initialized;

    notifyListeners();
  }
}
