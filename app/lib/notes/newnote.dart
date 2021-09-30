import 'package:app/notes/notes.dart';
import 'package:flutter/material.dart';
import 'database/databasemanager.dart';
import 'package:google_fonts/google_fonts.dart';

class NewNote extends StatefulWidget {
  NewNote({Key? key, required this.email}) : super(key: key);
  final email;

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              savenote();
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Container(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration.collapsed(
                      hintText: "Enter Title",
                    ),
                    style: GoogleFonts.aleo(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    )),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextFormField(
                    controller: _desController,
                    decoration: InputDecoration.collapsed(
                      hintText: "Note Description",
                    ),
                    style: GoogleFonts.jaldi(
                      fontSize: 20.0,
                      color: Colors.grey,
                    ),
                    maxLines: 20,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void savenote() async {
    await noted.addnotes(
        _titleController.text, _desController.text, widget.email);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Notes()));
  }
}
