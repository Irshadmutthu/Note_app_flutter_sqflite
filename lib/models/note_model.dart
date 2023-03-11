class NotesModel {
  int? id;
  String title;
  String body;
  DateTime creationdate;
  NotesModel(
      {this.id,
      required this.title,
      required this.body,
      required this.creationdate});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "creationdate": creationdate
    };
  }
}
