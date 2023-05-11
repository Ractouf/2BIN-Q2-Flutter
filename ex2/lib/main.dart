import 'package:ex2/propriete_row.dart';
import 'package:ex2/propriete.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var showEnVente = false;

  @override
  Widget build(BuildContext context) {
    final displayedProprietes = [
      for (var propriete in defaultProprietes)
        if (propriete.aVendre == showEnVente) propriete
    ];

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("A louer"),
              Switch(
                  value: showEnVente,
                  onChanged: (bool value) {
                    setState(() {
                      showEnVente = value;
                    });
                  }),
              const Text("A vendre"),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width: 500,
              child: ListView.builder(
                itemCount: displayedProprietes.length,
                itemBuilder: (context, index) {
                  return Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.lightGreen)),
                      ),
                      child:
                          ProprieteRow(propriete: displayedProprietes[index]));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
