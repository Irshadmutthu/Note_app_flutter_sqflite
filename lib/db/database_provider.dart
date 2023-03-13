import 'package:note_app/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;
  Future<Database?> get getdatabase async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    final dbPath = await getDatabasesPath();
    String _dbName = "note_app.db";
    return await openDatabase(join(dbPath, _dbName),
        onCreate: (db, version) async {
      await db.execute('''
CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,body TEXT,creationdate DATE)

''');
    }, version: 1);
  }

  addNote(NotesModel notesModel) async {
    final db = await getdatabase;
    await db!.insert("notes", notesModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getnotes() async {
    final db = await getdatabase;
    List<Map<String, dynamic>> maplist = [];
    maplist = await db!.query("notes");
    return maplist;
  }

  deletNote(int id) async {
    final db = await getdatabase;
    db!.delete("notes", where: "id = ?", whereArgs: [id]);
  }

  updateNote(NotesModel note) async {
    final db = await getdatabase;
    db!.update("notes", note.toMap(),
        where: "id = ?",
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
