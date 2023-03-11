import 'package:flutter/material.dart';

class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodycontroller = TextEditingController();
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
                child:
                    ElevatedButton(onPressed: () {}, child: Text("Add note")))
          ],
        ),
      ),
    );
  }
}
