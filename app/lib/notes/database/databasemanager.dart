import 'package:cloud_firestore/cloud_firestore.dart';

class noted {
  //Get data
  static Future<List?> shownotes() async {
    final savednotes = FirebaseFirestore.instance.collection("notes");
    List<dynamic> notesdata = [];
    await savednotes.get().then((QuerySnapshot) {
      QuerySnapshot.docs.forEach((element) {
        notesdata.add(element.data());
        print(element.id);
      });
    });
    return notesdata;
  }

// Add notes
  static Future addnotes(String title, String des, String email) async {
    final addnotes = FirebaseFirestore.instance.collection('notes');
    await addnotes.doc().set({"note": title, "des": des, "email": email});
  }

//update data

//delete notes

  static Future noteid() async {
    final savednotes = FirebaseFirestore.instance.collection("notes");
    List<String> userid = [];
    await savednotes.get().then((QuerySnapshot) {
      QuerySnapshot.docs.forEach((element) {
        userid.add(element.id);
      });
    });
    return userid;
  }

  static Future deletenote(String id) async {
    final deletenote = FirebaseFirestore.instance.collection('notes');
    await deletenote.doc(id).delete();
  }

  //update

  static Future updatenotes(String title, String des, String id) async {
    final addnotes = FirebaseFirestore.instance.collection('notes');
    await addnotes.doc(id).update({
      "note": title,
      "des": des,
    });
  }
}
