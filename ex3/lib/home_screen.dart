import 'my_form.dart';
import 'note.dart';
import 'package:flutter/material.dart';

import 'note_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Note> _notes = defaultNotes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Damien"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.lightGreen),
                      ),
                    ),
                    child: NoteRow(
                      note: _notes[index],
                      onRemove: (note) => setState(() => _notes.remove(note)),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 200,
              child: MyForm(
                addNote: (note) => setState(() => _notes.add(note)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
