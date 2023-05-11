import 'package:flutter/material.dart';

class EmergencyViewModel extends ChangeNotifier {
  String _sosBase = "I'm having an emergency at @loc, send help!";
  final List<String> _phonesSos = ["0495204191", "0495204190"];

  String get sosBase => _sosBase;
  List<String> get phonesSos => _phonesSos;

  void changeSos(String newSos) {
    _sosBase = newSos;

    notifyListeners();
  }

  void addPhoneSos(String phone) {
    _phonesSos.add(phone);

    notifyListeners();
  }

  void deltePhoneSos(String phone) {
    _phonesSos.remove(phone);

    notifyListeners();
  }
}