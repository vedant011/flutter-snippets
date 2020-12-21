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

  void spanishToEnglish() async {
    inputText = inputTextController.text;
    var result = await FirebaseLanguage.instance
        .languageTranslator(
            SupportedLanguages.Spanish, SupportedLanguages.English)
        .processText(inputText);
    setState(() {
      translatedText = result;
    });
  }

  void englishToSpanish() async {
    inputText = inputTextController.text;
    var result = await FirebaseLanguage.instance
        .languageTranslator(
            SupportedLanguages.English, SupportedLanguages.Spanish)
        .processText(inputText);
    setState(() {
      translatedText = result;
    });
  }

  void identifyLanguage() async {
    inputText = inputTextController.text;
    var result = await FirebaseLanguage.instance
        .languageIdentifier()
        .processText(inputText);

    setState(() {
      identifiedLang = result[0].languageCode; //returns most probable
    });
  }

  Color buttonColor = Colors.red[300];
  Color textboxColor = Colors.white12;

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
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your Text Here',
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Spanish to English",
                        style: TextStyle(color: Colors.white)),
                    color: buttonColor,
                    onPressed: spanishToEnglish,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  RaisedButton(
                    child: Text("English to Spansih",
                        style: TextStyle(color: Colors.white)),
                    color: buttonColor,
                    onPressed: englishToSpanish,
                  ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                width: 200,
                padding: EdgeInsets.all(17),
                child: Center(child: Text(translatedText)),
                decoration: BoxDecoration(
                  color: textboxColor,
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text("Identify Language",
                    style: TextStyle(color: Colors.white)),
                color: buttonColor,
                onPressed: identifyLanguage,
              ),
              SizedBox(height: 25),
              Container(
                width: 200,
                padding: EdgeInsets.all(17),
                child: Center(child: Text(identifiedLang)),
                decoration: BoxDecoration(
                  color: textboxColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
