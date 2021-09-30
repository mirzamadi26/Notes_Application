import 'package:app/notes/authentication.dart';
import 'package:app/notes/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  bool loading = false;
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/cover.png"))))),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text("Create and Manage your Notes",
              style: GoogleFonts.galindo(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )),
        ),
        loading
            ? CircularProgressIndicator()
            : SignInButton(Buttons.GoogleDark, onPressed: () async {
                setState(() {
                  loading = true;
                });
                dynamic result = await Authentication().googleSignin();
                setState(() {
                  loading = false;
                });
                if (result != null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Notes()));
                }
              }),
        SizedBox(
          height: 28,
        )
      ],
    )));
  }
}
