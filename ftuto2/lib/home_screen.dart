import 'package:flutter/material.dart';

import 'contact.dart';
import 'contact_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var showFavorites = false;
  void _toggleFavorites() => setState(() => showFavorites = !showFavorites);

  @override
  Widget build(BuildContext context) {
    final displayedContacts = [
      for (var contact in defaultContacts)
        if (!showFavorites || contact.isFavorite) contact
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact list"),
        actions: [
          IconButton(
            icon: Icon(showFavorites ? Icons.star : Icons.star_border),
            onPressed: _toggleFavorites,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 512.0,
            child: ListView.builder(
              itemCount: displayedContacts.length,
              itemBuilder: (context, index) =>
                  ContactRow(contact: displayedContacts[index]),
            ),
          ),
        ),
      ),
    );
  }

}
