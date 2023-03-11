import 'package:flutter/material.dart';
import 'package:note_app/screens/add_note.dart';
import 'package:note_app/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "home",
      routes: {
        "home": (context) => const Homepage(),
        "addnote": (context) => const Addnote(),
      },
      home: const Homepage(),
    );
  }
}
