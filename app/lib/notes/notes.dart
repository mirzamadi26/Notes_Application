import 'package:app/notes/authentication.dart';
import 'package:app/notes/edit.dart';
import 'package:app/notes/login.dart';
import 'package:app/notes/newnote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/notes/database/databasemanager.dart';

class Notes extends StatefulWidget {
  Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  String? user;
  getemaildata() {
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      user = auth.currentUser!.email;
    });
  }

  List<dynamic> allnotes = [];
  List<String> uid = [];
  showallnotes() async {
    dynamic resultant = await noted.shownotes();
    dynamic userid = await noted.noteid();
    setState(() {
      allnotes = resultant;
      uid = userid;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showallnotes();
    getemaildata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notes"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  await Authentication.googlesignout();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                icon: Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewNote(
                          email: user,
                        )));
          },
          child: Icon(Icons.add),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('notes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<String> title = [];

                    List<String> des = [];

                    List<String> ids = [];

                    snapshot.data!.docs.forEach((element) {
                      if (element['email'] == user) {
                        title.add(element['note']);
                        des.add(element['des']);
                        ids.add(element.id);
                      }
                    });
                    if (title.isNotEmpty) {
                      return ListView.builder(
                          itemCount: title.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.5,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            decoration: BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ListView(
                                              children: [
                                                ListTile(
                                                    title: Center(
                                                      child: Text(
                                                        title[index],
                                                        style: TextStyle(
                                                          fontSize: 40,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    trailing: IconButton(
                                                        onPressed: () async {
                                                          confirmdelete();
                                                          await noted
                                                              .deletenote(
                                                                  uid[index]);
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Notes()));
                                                        },
                                                        icon:
                                                            Icon(Icons.delete)),
                                                    leading: TextButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Edit(
                                                                      title: title[
                                                                          index],
                                                                      des: des[
                                                                          index],
                                                                      id: ids[
                                                                          index])));
                                                        },
                                                        child: Text("Edit",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)))),

                                                // Center(
                                                //   child: Text(
                                                //     "${allnotes[index]['note']}",
                                                //     style: TextStyle(
                                                //       fontSize: 40,
                                                //       fontWeight: FontWeight.bold,
                                                //     ),
                                                //   ),
                                                // ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Text(
                                                    des[index],
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                ),
                                              ],
                                            ));
                                      });
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          title[index],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          });
                    }
                  }

                  return Center(child: Text("You have no Notes Yet!!!"));
                })));
  }

  // void delete() async {
  //   await noted.deletenotes();
  // }

  void confirmdelete() {
    var alertDialog = AlertDialog(
      title: Text("Deleted Successfully"),
      content: Text("Notes!!!!"),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
