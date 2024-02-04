import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_note_app/database/NotesDatabase.dart';
import 'package:flutter_note_app/screens/EditNote.dart';
import 'package:flutter_note_app/services/NoteService.dart';
import 'package:flutter_note_app/tools/P.dart';
import 'package:flutter_note_app/tools/tools.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NoteService _noteService = new NoteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: GradientAppBar(
        title: Text("Notepad"),
        gradient: LinearGradient(colors: [P.gradientColor1, P.gradientColor2]),
      ),
      //Floating Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: P.gradientColor1,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          await Navigator.pushNamed(context, "/EditNote");

          setState(() {
            _noteService.readDatabase();
          });
        },
      ),
      body: FutureBuilder(
          future: _noteService.readDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var result = snapshot.data!;
              // Use result without null check
              return Stack(
                children: [
                  ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        dynamic item = result[index];

                        return BuildNoteRowView(item);
                      })
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Slidable BuildNoteRowView(item) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) =>
                handleDeleteNoteAction(int.parse(item['id'].toString())),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            leading: Icon(Icons.dataset_rounded),
            title: Text(item['title']),
            subtitle: Text(item['content']),
          ),
        ),
      ),
    );
  }

  void handleDeleteNoteAction(int noteId) {
    print(noteId);
    _noteService.deleteNote(noteId);

    setState(() {
      _noteService.readDatabase();
    });
  }
}
