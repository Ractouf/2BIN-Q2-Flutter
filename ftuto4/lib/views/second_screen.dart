import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/click_view_model.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second screen"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Hello from second screen."),
            const SizedBox(height: 16),
            Consumer<ClickViewModel>(
              builder: (context, viewModel, child) =>
                  Text("There were ${viewModel.clicks} clicks in the first page."),
            ),
          ],
        ),
      ),
    );
  }
}
