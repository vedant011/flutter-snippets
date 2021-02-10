import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final FacebookLogin facebookLogin = FacebookLogin();

String name = 'name';
String email = 'email';
String imageUrl = 'https://www.w3schools.com/w3css/img_lights.jpg';

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async{
  await googleSignIn.signOut();
  name = 'no name';
  email = 'no email';
  imageUrl = 'url';
  print("User Sign Out");
}

Future<String> initiateFacebookLogin() async {
  var facebookLogin = FacebookLogin();
  var facebookLoginResult =
  await facebookLogin.logInWithReadPermissions(['email', 'public_profile']);
  switch (facebookLoginResult.status) {
    case FacebookLoginStatus.error:
      print("Error ${FacebookLoginStatus.error.toString()}");
      break;
    case FacebookLoginStatus.cancelledByUser:
      print("CancelledByUser");
      break;
    case FacebookLoginStatus.loggedIn:
      var graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult
              .accessToken.token}');

      var profile = json.decode(graphResponse.body);
      print("TEMP${profile.toString()}");

      name = profile['name'];
      email = profile['email'];
      imageUrl = profile['picture']['data']['url'];
      break;
  }
  return 'signInWithGoogle succeeded: ${FacebookLoginStatus.loggedIn}';
}

void signOutFacebook() async{
  await facebookLogin.logOut();
  name = 'no name';
  email = 'no email';
  imageUrl = 'url';
  print("User Sign Out");
}
