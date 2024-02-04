import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_note_app/database/NotesDatabase.dart';
import 'package:flutter_note_app/model/NotesModel.dart';
import 'package:flutter_note_app/services/NoteService.dart';
import 'package:flutter_note_app/tools/P.dart';
import 'package:flutter_note_app/tools/tools.dart';

class EditNote extends StatefulWidget {
  _EditNote createState() => _EditNote();
}

class _EditNote extends State<EditNote> {
  TextEditingController _titleTextController = TextEditingController();
  TextEditingController _contentTextController = TextEditingController();
  NoteService _noteService = new NoteService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(NoteColors[this.noteColor]['l']),
        appBar: GradientAppBar(
          title: const Text("Create New Notepad"),
          gradient:
              LinearGradient(colors: [P.gradientColor1, P.gradientColor2]),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BuildTextField(
                emailController: _titleTextController,
                isMultiLine: false,
                isBorderLine: true,
                hintText: "Write Title here",
                textAlign: TextAlign.center,
                iconName: Icons.abc,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BuildTextField(
                emailController: _contentTextController,
                isMultiLine: true,
                isBorderLine: true,
                hintText: "Write Details here",
                textAlign: TextAlign.center,
                iconName: Icons.abc,
                width: double.infinity,
              ),
            ),
            ElevatedButton.icon(
              onPressed: handleSaveButton,
              label: const Text(
                "Save note",
              ),
              icon: Icon(Icons.save, color: P.gradientColor2),
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ));
  }

  void handleSaveButton() async {
    // Save New note
    NoteModel noteObj = NoteModel(
        title: _titleTextController.text, content: _contentTextController.text);
    try {
      print("inserting");
      await _noteService.insertNote(noteObj);
    } catch (e) {
      print('Error inserting row');
    } finally {
      Navigator.pop(context);
      return;
    }
  }
}
