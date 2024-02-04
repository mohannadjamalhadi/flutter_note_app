import 'package:flutter_note_app/model/NotesModel.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static final _name = "NotesDatabase.db";
  static final _version = 1;

  late Database database;
  static final tableName = 'notes';

  initDatabase() async {
    database = await openDatabase(_name, version: _version,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE $tableName (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    title TEXT,
                    content TEXT
                  
                    )''');
    });
  }

  Future<int> insertNote(NoteModel note) async {
    return await database.insert(tableName, note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateNote(NoteModel note) async {
    return await database.update(tableName, note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, Object?>>> getAllNotes() async {
    return await database.query(tableName);
  }

  Future<Map<String, dynamic>?> getNotes(int id) async {
    var result =
        await database.query(tableName, where: 'id = ?', whereArgs: [id]);

    if (result.length > 0) {
      return result.first;
    }

    return null;
  }

  Future<int> deleteNote(int id) async {
    return await database.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  closeDatabase() async {
    await database.close();
  }
}
