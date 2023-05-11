import 'package:flutter/material.dart';

import 'mr_form.dart';
import 'my_square.dart';
import 'my_switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var color = "red";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tutoriel 3")),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            MySquare(color: color),
            MySwitch(
              color: color,
              setColor: (value) => setState(() => color = value),
            ),
            MyForm((value) => setState(() => color = value)),
          ],
        ),
      ),
    );
  }
}
