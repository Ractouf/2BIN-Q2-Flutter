class Note {
  final String titre;
  final String texte;

  Note({required this.titre, required this.texte});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Note && runtimeType == other.runtimeType && titre == other.titre;

  @override
  int get hashCode => titre.hashCode;
}

List<Note> _createNotes() {
  final notes = List.generate(
      100,
          (i) => Note(titre: "$i : Le retour", texte: "${i + 1} ceci est du texte")
  );

  return [...notes];
}

final defaultNotes = _createNotes();