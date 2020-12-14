import 'package:flutter/material.dart';
import 'package:project_dsc/screens/login_screen.dart';
import 'package:project_dsc/screens/home_screen.dart';
import 'package:project_dsc/screens/translator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        backgroundColor: Colors.white60,
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        Translation.id: (context) => Translation(),
      },
    );
  }
}
