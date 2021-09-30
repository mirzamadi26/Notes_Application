import 'package:flutter/material.dart';
import 'database/databasemanager.dart';

class Edit extends StatefulWidget {
  Edit({Key? key, required this.title, required this.des, required this.id})
      : super(key: key);
  final title, des, id;

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _desController = TextEditingController();

  passingvalue() {
    setState(() {
      _titleController.text = widget.title;
      _desController.text = widget.des;
    });
  }

  @override
  void initState() {
    super.initState();
    passingvalue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              //   updatenotes();
              await noted.updatenotes(
                  _titleController.text, _desController.text, widget.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              "Update",
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
                  style: TextStyle(
                    fontSize: 32.0,
                    fontFamily: "lato",
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextFormField(
                    controller: _desController,
                    decoration: InputDecoration.collapsed(
                      hintText: "Note Description",
                    ),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "lato",
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
}
