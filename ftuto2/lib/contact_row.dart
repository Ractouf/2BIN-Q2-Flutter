import 'package:flutter/material.dart';

import 'contact.dart';

class ContactRow extends StatelessWidget {
  final Contact contact;

  const ContactRow({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.name),
      subtitle: Text(contact.phone),
      trailing:
      Icon(contact.isFavorite ? Icons.star : Icons.star_border),
    );
  }
}
