import 'package:flutter/material.dart';

import 'note.dart';

class MyForm extends StatefulWidget {
  final void Function(Note) addNote;
  
  const MyForm({Key? key, required this.addNote}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final titleController = TextEditingController();
  final contextController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    contextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Column(
        children: [
          Expanded(
            child: TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Note title"),
              validator: (value) =>
              (value == null || value.isEmpty) ? "Title cannot be empty" : null,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: contextController,
              decoration: const InputDecoration(labelText: "Note context"),
              validator: (value) =>
              (value == null || value.isEmpty) ? "Context cannot be empty" : null,
            ),
          ),
          ElevatedButton(
            child: const Text("Create note"),
            onPressed: () {
              if (key.currentState!.validate()) {
                widget.addNote(Note(titre: titleController.text, texte: contextController.text));
                titleController.text = "";
                contextController.text = "";
              }
            },
          )
        ],
      ),
    );
  }
}
