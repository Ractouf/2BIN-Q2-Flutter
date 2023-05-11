import 'package:flutter/material.dart';
import '../models/ghibli.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FetchState { loading, error, done }

class _HomeScreenState extends State<HomeScreen> {
  var state = FetchState.loading;
  var message = "Loading…";
  final List<Film> films = [];

  Future<void> _initFilms() async {
    try {
      var response = await Film.fetchFilms();
      setState(() {
        state = FetchState.done;
        films.addAll(response);
      });
    } catch (error) {
      setState(() {
        state = FetchState.error;
        message = error.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initFilms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ex 5")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: state != FetchState.done
            ? Column(children: [Expanded(child: Center(child: Text(message)))])
            : ListView.separated(
          itemCount: films.length,
          itemBuilder: (context, index) => FilmRow(film: films[index]),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}

class FilmRow extends StatelessWidget {
  final Film film;

  const FilmRow({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            return getSmallWidget();
          } else {
            return getBigWidget();
          }
        }
    );
  }

  Widget getBigWidget() {
    return Row(
      children: [
        Image.network(film.image, width: 200),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(film.releaseDate, style: const TextStyle(color: Colors.grey)),
                  const Divider(),
                  Text(film.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Divider(),
                  Text("${film.rtScore} %", style: const TextStyle(color: Colors.green)),
                  const Divider(),
                  Text("${film.runningTime} minutes"),
                  const Divider(),
                  Text("Directed by ${film.director}"),
                  const Divider(),
                  Text(film.description)
                ],
              ),
            )
        )
      ],
    );
  }

  Widget getSmallWidget() {
    return Column(
      children: [
        Image.network(film.movieBanner, width: 400),
        Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(film.releaseDate, style: const TextStyle(color: Colors.grey)),
                  const Divider(),
                  Text(film.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Divider(),
                  Text("${film.rtScore} %", style: const TextStyle(color: Colors.green)),
                  const Divider(),
                  Text("${film.runningTime} minutes"),
                  const Divider(),
                  Text("Directed by ${film.director}"),
                  const Divider(),
                  Text(film.description)
                ],
              ),
        )
      ],
    );
  }
}
