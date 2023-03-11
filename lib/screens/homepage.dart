import 'package:flutter/material.dart';
import 'package:note_app/db/database_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  Future<List<Map<String, dynamic>>>? getnotes() async {
    final notes = await DatabaseProvider.db.getnotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
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
                return ListView.builder(
                    itemBuilder: (context, index) {
                      String title = noteData.data![index]['title'];
                      String body = noteData.data![index]['body'];
                      int id = noteData.data![index]["id"];
                      String creationdate =
                          noteData.data![index]['creationdate'];

                      return Card(
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
                                          context, "home", (route) => false);
                                    },
                                    icon: const Icon(Icons.delete)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: noteData.data!.length);
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
