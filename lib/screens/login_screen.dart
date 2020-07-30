import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../components/reusable_button.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextField.copyWith(hintText: "Enter Your Email"),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration:
                    kTextField.copyWith(hintText: "Enter Your Password"),
              ),
              SizedBox(
                height: 24.0,
              ),
              ReusableButton(
                title: "Log In",
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Fluttertoast.showToast(
                          msg: "Logged In",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pushNamed(context, 'chat_screen');
                    }
                    setState(() {
                      loading = false;
                    });
                  } catch (e) {
                    Fluttertoast.showToast(
                        msg: "Wrong Credentials",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    setState(() {
                      loading = false;
                    });

                    print("--> failes to login");
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
