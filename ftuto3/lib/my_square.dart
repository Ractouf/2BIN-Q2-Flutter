import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  final colors = {
    "red": Colors.red,
    "green": Colors.green,
    "blue": Colors.blue,
    "yellow": Colors.yellow,
    "black": Colors.black,
    "white": Colors.white,
  };
  final String color;

  MySquare({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          color: colors[color] ?? Colors.grey,
        ),
      ),
    );
  }
}
