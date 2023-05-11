import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Items extends ChangeNotifier {
  static const baseUrl = "https://unreal-api.azurewebsites.net/photos";

  late Future<List<dynamic>> _item;

  Future<List<dynamic>> get items => _item;

  Items() {
    _item = fetchItems();
  }

  Future<List<dynamic>> fetchItems() async {
    var response = await http.get(Uri.parse("$baseUrl/"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void postItem(String data) async {
    await http.post(Uri.parse("$baseUrl/"),
        headers: {"Content-Type": "application/json"},
        body: data);

    _item = fetchItems();

    notifyListeners();
  }
}
