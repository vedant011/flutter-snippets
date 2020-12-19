import 'package:flutter/material.dart';
import 'package:firebase_mlkit_language/firebase_mlkit_language.dart';

class Translation extends StatefulWidget {
  static const String id = 'translation';
  @override
  _TranslationState createState() => _TranslationState();
}

class _TranslationState extends State<Translation> {
  @override
  void initState() {
    super.initState();
  }

  var translatedText = "Translated Text";
  var inputText;
  var identifiedLang = "Detected Language";

  final inputTextController = TextEditingController();
  final LanguageIdentifier languageIdentifier =
      FirebaseLanguage.instance.languageIdentifier();

  @override
  void dispose() {
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: TextField(
                  controller: inputTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your Text Here',
                  ),
                ),
              ),
              SizedBox(height: 50),
              RaisedButton(
                  child:
                      Text("Translate", style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: onPressed),
              SizedBox(height: 25),
              Container(
                width: 200,
                padding: EdgeInsets.all(20),
                child: Center(child: Text(translatedText)),
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
                width: 200,
                padding: EdgeInsets.all(20),
                child: Center(child: Text(identifiedLang)),
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
