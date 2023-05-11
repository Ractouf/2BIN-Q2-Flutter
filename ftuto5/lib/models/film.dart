import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Film {
  static const baseUrl = "https://sebstreb.github.io/flutter-fiche-5/films-api";

  final int id;
  final String title;
  final String director;
  final int duration;
  final String link;

  const Film(this.id, this.title, this.director, this.duration, this.link);

  Film.fromJson(Map<String, dynamic> jsonObj)
      : this(
    jsonObj["id"],
    jsonObj["title"],
    jsonObj["director"],
    jsonObj["duration"],
    jsonObj["link"],
  );

  @override
  String toString() =>
      'Film: $title, directed by $director, $duration min, $link';

  static Future<Film> fetchFilm(int id) async {
    var response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode != 200) {
      throw Exception("Error ${response.statusCode} fetching movie");
    }

    return Film.fromJson(jsonDecode(response.body));
  }

  static Future<List<Film>> fetchFilms() async {
    var response = await http.get(Uri.parse("$baseUrl/"));

    if (response.statusCode != 200) {
      throw Exception("Error ${response.statusCode} fetching movies");
    }

    return compute((input) {
      final jsonList = jsonDecode(input as String);
      return jsonList.map<Film>((jsonObj) => Film.fromJson(jsonObj)).toList();
    }, response.body);
  }
}
