import 'package:ex4/view/article_screen.dart';
import 'package:ex4/view/form_screen.dart';
import 'package:ex4/view/list_screen.dart';
import 'package:ex4/view_model/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ArticleViewModel>(
      create: (context) => ArticleViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/list",
        routes: {
          "/form": (context) => const FormScreen(),
          "/article": (context) => const ArticleScreen(),
          "/list": (context) => const ListScreen(),
        },
      ),
    );
  }
}

