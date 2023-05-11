import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/click_view_model.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("First screen")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Hello from first screen."),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final viewModel = Provider.of<ClickViewModel>(
                  context,
                  listen: false,
                );
                viewModel.increment();
              },
              child: const Text("click me"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/second"),
              child: const Text("Go to second screen"),
            ),
          ],
        ),
      ),
    );
  }
}

