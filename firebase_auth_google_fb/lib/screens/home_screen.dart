import 'package:flutter/material.dart';
import 'package:project_dsc/sign_in.dart';
import 'package:firebase_mlkit_language/firebase_mlkit_language.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var translatedText = "Translated Text";
  var inputText;
  var identifiedLang = "Detected Language";

  final inputTextController = TextEditingController();
  final LanguageIdentifier languageIdentifier =
      FirebaseLanguage.instance.languageIdentifier();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    inputTextController.dispose();
    super.dispose();
  }

  void onPressed() async {
    inputText = inputTextController.text;
    var result = await FirebaseLanguage.instance
        .languageTranslator(
            SupportedLanguages.English, SupportedLanguages.Spanish)
        .processText(inputText);
    setState(() {
      translatedText = result;
    });
  }

  void onPoked() async {
    inputText = inputTextController.text;
    var result = await FirebaseLanguage.instance
        .languageIdentifier()
        .processText(inputText);

    setState(() {
      identifiedLang = result[0].languageCode; //returns most probable
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 10),
              Text(
                name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                email,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  signOutFacebook();
                  Navigator.pop(context);
                },
                color: Colors.teal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
              TextField(controller: inputTextController),
              SizedBox(height: 50),
              RaisedButton(
                  child:
                      Text("Translate", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: onPressed),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.all(20),
                child: SizedBox(child: Text(translatedText), height: 20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                  child: Text("Identify Language",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: onPoked),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(identifiedLang),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
