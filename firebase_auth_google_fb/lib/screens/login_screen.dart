import 'package:flutter/material.dart';
import 'package:project_dsc/sign_in.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                OutlineButton(
                  onPressed: () {
                    signInWithGoogle().whenComplete(
                      () {
                        Navigator.pushNamed(context, HomeScreen.id);
                      },
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  highlightElevation: 0,
                  color: Colors.grey,
                  borderSide: BorderSide(color: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                OutlineButton(
                  onPressed: () {
                    initiateFacebookLogin().whenComplete(
                      () {
                        Navigator.pushNamed(context, HomeScreen.id);
                      },
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  highlightElevation: 0,
                  borderSide: BorderSide(color: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign in with Facebook',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
