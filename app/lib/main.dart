import 'package:app/notes/login.dart';
import 'package:app/notes/notes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(theme: ThemeData.dark(), home: Login()));
}
