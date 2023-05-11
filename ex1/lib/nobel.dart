import 'package:flutter/material.dart';

class Nobel extends StatelessWidget {
  final String firstname;
  final String surname;
  final String motivation;

  const Nobel(this.motivation, {Key? key, this.firstname = "", this.surname = ""})
  : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, right: 30, left: 30, bottom: 10),
          padding: const EdgeInsets.all(10.0),
          color: Colors.lightBlue,
          child: Text(motivation, style: const TextStyle(color: Colors.white)),
        ),
        Text(
          "$firstname $surname",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}