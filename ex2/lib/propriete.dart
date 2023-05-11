class Propriete {
  final bool aVendre;
  final bool estMaison;
  final int surface;
  final int nbrChambres;
  final int prix;

  Propriete({
    required this.aVendre,
    required this.estMaison,
    required this.surface,
    required this.nbrChambres,
    required this.prix,
  });
}

List<Propriete> _createProprietes() {
  final proprietesAVendre = List.generate(
      100,
      (i) => Propriete(
          aVendre: true,
          estMaison: i % 2 == 0 ? true : false,
          surface: (i + 1) * 15,
          nbrChambres: i + 1,
          prix: (i + 1) * 30000
      )
  );

  final proprietesALouer = List.generate(
      100,
      (i) => Propriete(
          aVendre: false,
          estMaison: i % 2 == 0 ? true : false,
          surface: (i + 1) * 20,
          nbrChambres: i + 1,
          prix: (i + 1) * 1000
      )
  );

  return [...proprietesAVendre, ...proprietesALouer];
}

final defaultProprietes = _createProprietes();
