import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_app/db/database_provider.dart';
import 'package:note_app/models/note_model.dart';

class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  addnote(NotesModel notesModel) {
    try {
      DatabaseProvider.db.addNote(notesModel);
      log("note added success");
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController bodycontroller = TextEditingController();
  String title = '';
  String body = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Title",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: titleController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(" Body",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(
              controller: bodycontroller,
              maxLines: null,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        title = titleController.text;
                        body = bodycontroller.text;
                      });
                      if (titleController.text.isNotEmpty &&
                          bodycontroller.text.isNotEmpty) {
                        addnote(NotesModel(
                            title: title,
                            body: body,
                            creationdate: DateTime.now()));
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "home");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Enter title and body to continue")));
                      }
                    },
                    child: const Text("Add note")))
          ],
        ),
      ),
    );
  }
}
