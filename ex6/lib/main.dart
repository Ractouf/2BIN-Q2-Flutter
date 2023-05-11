import 'package:ex6/view_model/items.dart';
import 'package:ex6/views/add_item.dart';
import 'package:ex6/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Items>(
      create: (context) => Items(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/items",
        routes: {
          "/items": (context) => const MyHomeScreen(),
          "/add-item": (context) => const AddItem(),
        },
      )
    );
  }
}
