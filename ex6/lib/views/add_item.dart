import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/items.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final titleController = TextEditingController();
  final thumbnailController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    thumbnailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<Items>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("New article"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Item title"),
                validator: (value) => (value == null || value == "")
                    ? "Title can't be empty"
                    : null,
              ),
              TextFormField(
                controller: thumbnailController,
                decoration: const InputDecoration(labelText: "Item thumbnail"),
                validator: (value) => (value == null || value == "")
                    ? "thumbnail can't be empty"
                    : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text("Create item"),
                onPressed: () {
                  if (key.currentState!.validate()) {
                    Map<String, String> data = {'title': titleController.text, 'thumbnailUrl': thumbnailController.text};
                    final String jsonString = jsonEncode(data);

                    viewModel.postItem(jsonString);

                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
