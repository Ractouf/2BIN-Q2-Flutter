import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/items.dart';
import 'item_row.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  MyHomeScreenState createState() => MyHomeScreenState();
}

class MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Items>(
        builder: (context, viewModel, child) => Scaffold(
              appBar: AppBar(
                title: const Text('FutureBuilder Example'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, "/add-item"),
                child: const Icon(Icons.add),
              ),
              body: FutureBuilder<List<dynamic>>(
                future: Future.delayed(
                    const Duration(seconds: 1), () => viewModel.items),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final reversedData = snapshot.data?.reversed.toList();
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final post = reversedData![index];
                        return ItemRow(post: post);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  } else {
                    return Center(child: LoadingFilling.square());
                  }
                },
              ),
            )
    );
  }
}
