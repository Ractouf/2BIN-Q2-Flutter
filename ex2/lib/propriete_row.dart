import 'package:ex2/propriete.dart';
import 'package:flutter/material.dart';

class ProprieteRow extends StatelessWidget {
  final Propriete propriete;

  const ProprieteRow({
    Key? key,
    required this.propriete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          '${propriete.aVendre ? 'A vendre: ' : 'A louer: '} '
          '${propriete.estMaison ? 'Maison de ' : 'Appartement de '} '
          '${propriete.surface} m²'
      ),
      subtitle: Text(
          '${propriete.nbrChambres} chambre(s) - '
          '${propriete.prix} ${propriete.aVendre ? '€' : '€/mois'}'
      ),
    );
  }
}
