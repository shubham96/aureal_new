import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/home/home.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithCredential(AuthCredential credential) =>
      _auth.signInWithCredential(credential);
  Future<void> logout() => _auth.signOut();
  Stream<User?> get currentUser => _auth.authStateChanges();
}

class AuthBloc {
  final authService = AuthService();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late String registrationToken;

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //   ],
  // );

  Stream<User?> get currentUser => authService.currentUser;

  // loginGoogle(context) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     Dio dio = Dio();
  //     await _messaging.getToken().then((token) {
  //       registrationToken = token;
  //       print(
  //           '//////////////////////////////////////////////////////${token.toString()} /////////////////////////////////////////////////////////');
  //     });
  //     GoogleSignInAccount result = await _googleSignIn.signIn();
  //     GoogleSignInAuthentication googleKey = await result.authentication;
  //     print(googleKey.idToken.toString());
  //     print(googleKey.accessToken.toString());
  //     String url = 'https://api.aureal.one/public/userAuth';
  //     var map = Map<String, dynamic>();
  //     map['identifier'] = googleKey.idToken.toString();
  //     map['registrationToken'] = registrationToken;
  //     map['loginType'] = 'google';
  //     print('registrationToken: ${map['registrationToken']}');
  //     FormData formData = FormData.fromMap(map);
  //     var response = await dio.post(url, data: formData);
  //     if (response.statusCode == 200) {
  //       print(response.data.toString());
  //       prefs.setString('token', response.data['userData']['token']);
  //       prefs.setString('userId', response.data['userData']['id']);
  //       prefs.setString('userName', response.data['userData']['username']);
  //
  //       if (response.data['userData']['olduser'] == true) {
  //         if (response.data['userData']['hive_username'] != null) {
  //           prefs.setString(
  //               'HiveUserName', response.data['userData']['hive_username']);
  //           Navigator.popAndPushNamed(context, Home.id);
  //         } else {
  //           Navigator.popAndPushNamed(context, HiveDetails.id);
  //         }
  //       } else {
  //         Navigator.popAndPushNamed(context, SelectLanguage.id);
  //       }
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: 'Could not log you in',
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Color(0xff3a3a3a),
  //           textColor: Color(0xffe8e8e8),
  //           fontSize: 12.0);
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  //
  // loginApple(context) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     Dio dio = Dio();
  //     await _messaging.getToken().then((token) {
  //       registrationToken = token;
  //       print(
  //           '//////////////////////////////////////////////////////${token.toString()} /////////////////////////////////////////////////////////');
  //     });
  //     final credential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );
  //     print(credential.givenName.toString());
  //     print(credential.familyName.toString());
  //     // if(credential.givenName != null || credential.familyName!=n)
  //     String appleName = (credential.givenName.toString() != null
  //         ? credential.givenName.toString()
  //         : '') +
  //         (credential.givenName.toString() != null ? ' ' : '') +
  //         (credential.familyName.toString() != null
  //             ? credential.familyName.toString()
  //             : '');
  //     print(credential.authorizationCode.toString());
  //     String url = 'https://api.aureal.one/public/userAuth';
  //     var map = Map<String, dynamic>();
  //     map['identifier'] = credential.authorizationCode.toString();
  //     map['registrationToken'] = registrationToken;
  //     map['loginType'] = 'apple';
  //     map['name'] = appleName;
  //     print('registrationToken: ${map['registrationToken']}');
  //     FormData formData = FormData.fromMap(map);
  //     var response = await dio.post(url, data: formData);
  //     if (response.statusCode == 200) {
  //       print(response.data.toString());
  //       prefs.setString('token', response.data['userData']['token']);
  //       prefs.setString('userId', response.data['userData']['id']);
  //       prefs.setString('userName', response.data['userData']['username']);
  //
  //       if (response.data['userData']['olduser'] == true) {
  //         if (response.data['userData']['hive_username'] != null) {
  //           prefs.setString(
  //               'HiveUserName', response.data['userData']['hive_username']);
  //           Navigator.popAndPushNamed(context, Home.id);
  //         } else {
  //           Navigator.popAndPushNamed(context, HiveDetails.id);
  //         }
  //       } else {
  //         Navigator.popAndPushNamed(context, SelectLanguage.id);
  //       }
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: 'Could not log you in',
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Color(0xff3a3a3a),
  //           textColor: Color(0xffe8e8e8),
  //           fontSize: 12.0);
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }
}

final FirebaseMessaging _messaging = FirebaseMessaging.instance;
Dio dio = Dio();
CancelToken cancel = CancelToken();
String? registrationToken;

Future hiveAuth(BuildContext context) async {

  SharedPreferences pref = await SharedPreferences.getInstance();

  await _messaging.getToken().then((value) {
    registrationToken = value;
  });

  String url = 'https://api.aureal.one/public/userAuth';
  var map = <String, dynamic>{};

  map['identifier'] = pref.getString('code');
  map['registrationToken'] = registrationToken;

  FormData formData = FormData.fromMap(map);
  Response? response = await dio.post(url, data: formData, cancelToken: cancel).then((value){
    if(value.statusCode == 200){
      pref.setString('token', value.data['userData']['token']);  // getting the registration Token from user
      pref.setString('userId', value.data['userData']['id']); // getting the userId assigned by Firebase or Aws
      pref.setString('userName', value.data['userData']['username']); // getting the username setup by the user

      if (value.data['userData']['hive_username'] != null) {
        pref.setString(
            'HiveUserName', value.data['userData']['hive_username']); // setting the HiveUsername into local Storage to be used later
        pref.setString(
            'access_token', value.data['userData']['hiveAccessToken']); // adding hive access token into local Storage to be used later
      }
      if (value.data['userData']['olduser'] == true) {
        Navigator.push(context, CupertinoPageRoute(builder: (context){
          return Home();
        }));
      } else {
        Navigator.push(context, CupertinoPageRoute(builder: (context){
          return Home();
        }));
      }
      print("This is one the API screen");
      print(value);
      return value;
    }
  });
} // Hive Auth to send the user access tokens to backend after HiveSigner or Keychain Response
