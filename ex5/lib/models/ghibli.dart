import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Film {
  static const baseUrl = "https://sebstreb.github.io/flutter-fiche-5/ghibli-films";

  final String id;
  final String title;
  final String image;
  final String movieBanner;
  final String description;
  final String releaseDate;
  final String director;
  final String runningTime;
  final String rtScore;

  const Film(this.id, this.title, this.image, this.movieBanner, this.description,
      this.releaseDate, this.director, this.runningTime, this.rtScore);

  Film.fromJson(Map<String, dynamic> jsonObj)
      : this(
    jsonObj["id"],
    jsonObj["title"],
    jsonObj["image"],
    jsonObj["movie_banner"],
    jsonObj["description"],
    jsonObj["release_date"],
    jsonObj["director"],
    jsonObj["running_time"],
    jsonObj["rt_score"],
  );

  @override
  String toString() =>
      'Film: $title, directed by $director, released $releaseDate, duration $runningTime';

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
      final jsonList = jsonDecode(input);
      return jsonList.map<Film>((jsonObj) => Film.fromJson(jsonObj)).toList();
    }, response.body);
  }
}
