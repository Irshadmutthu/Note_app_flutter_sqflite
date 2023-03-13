import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_app/db/database_provider.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  Future<List<Map<String, dynamic>>>? getnotes() async {
    final notes = await DatabaseProvider.db.getnotes();
    return notes;
  }

  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: getnotes(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> noteData) {
            if (noteData.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (noteData.connectionState == ConnectionState.done) {
              if (noteData.data!.isEmpty) {
                return const Center(
                  child: Text("No notes found"),
                );
              } else {
                return Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    // ignore: prefer_const_constructors
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "My",
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Notes",
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            final randomColorIndex =
                                Random().nextInt(_colors.length);

                            // Use the random color for this card
                            final cardColor = _colors[randomColorIndex];
                            String title = noteData.data![index]['title'];
                            String body = noteData.data![index]['body'];
                            int id = noteData.data![index]["id"];
                            String creationdate =
                                noteData.data![index]['creationdate'];

                            return Card(
                              color: cardColor,
                              child: ListTile(
                                title: Text(title),
                                subtitle: Text(body),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            DatabaseProvider.db.deletNote(id);
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                "home",
                                                (route) => false);
                                          },
                                          icon: const Icon(Icons.delete)),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "addnote", arguments: {
                                              "name": "updateNote",
                                              "title": title,
                                              "body": body,
                                              "id": id
                                            });
                                          },
                                          icon: const Icon(Icons.edit))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: noteData.data!.length),
                    ),
                  ],
                );
              }
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "addnote");
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
