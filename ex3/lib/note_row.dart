import 'package:flutter/material.dart';

import 'note.dart';

class NoteRow extends StatelessWidget {
  final Note note;
  final void Function(Note note) onRemove;

  const NoteRow ({Key? key, required this.note, required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.titre),
      subtitle: Text(note.texte),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onRemove(note),
      ),
    );
  }
}
