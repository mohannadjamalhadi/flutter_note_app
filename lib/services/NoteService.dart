import 'package:flutter_note_app/database/NotesDatabase.dart';
import 'package:flutter_note_app/model/NotesModel.dart';

class NoteService {
  Future<List<Map<String, dynamic>>> readDatabase() async {
    try {
      NotesDatabase notesDb = NotesDatabase();
      await notesDb.initDatabase();
      List<Map> notesList = await notesDb.getAllNotes();
      await notesDb.closeDatabase();
      List<Map<String, dynamic>> notesData =
          List<Map<String, dynamic>>.from(notesList);
      notesData.sort((a, b) => (a['title']).compareTo(b['title']));
      return notesData;
    } catch (e) {
      print('Error retrieving notes');
      return [{}];
    }
  }

  Future<void> insertNote(NoteModel note) async {
    NotesDatabase notesDb = NotesDatabase();
    await notesDb.initDatabase();
    int result = await notesDb.insertNote(note);
    await notesDb.closeDatabase();
  }

  // Delete Notes
  Future<void> deleteNote(int noteId) async {
    try {
      NotesDatabase notesDb = NotesDatabase();
      await notesDb.initDatabase();

      int result = await notesDb.deleteNote(noteId);

      await notesDb.closeDatabase();
    } catch (e) {
      print('Cannot delete notes');
    } finally {}
  }
}
