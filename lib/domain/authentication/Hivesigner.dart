
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../pages/home/home.dart';
import 'authentication.dart';

class HiveAccount extends StatelessWidget {
  HiveAccount({Key? key}) : super(key: key);



  // WebViewController controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..setBackgroundColor(const Color(0x00000000));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: WebViewWidget(controller: controller..setNavigationDelegate(NavigationDelegate(onWebResourceError: (WebResourceError error) {
      //
      // },
      //     onPageStarted: (String url)async{
      //       SharedPreferences prefs = await SharedPreferences.getInstance();
      //       var uri = Uri.parse(url);
      //       uri.queryParameters.forEach((key, value)  {
      //         if(key == 'access_token' ||
      //             key == 'username' ||
      //             key == 'code'){
      //           if(key == 'username' && prefs.getString('access_token') != null && prefs.getString('code') != null){
      //             prefs.setString('HiveUserName', value);
      //           }else{
      //             prefs.setString(key, value);
      //           }
      //         }
      //       });
      //       hiveAuth();
      //     }
      // ))..loadRequest(Uri.parse('https://hivesigner.com/oauth2/authorize?client_id=aureal&redirect_uri=%3Dhttp%253A%252F%252Flocalhost%253A3000%26&response_type=code&scope=offline,comment,vote,comment_option,custom_json')),),
      body: WebView(
        gestureRecognizers: Set()
          ..add(
            Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer(),
            ), // or null
          ),
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
        'https://hivesigner.com/oauth2/authorize?client_id=aureal&redirect_uri=%3Dhttp%253A%252F%252Flocalhost%253A3000%26&response_type=code&scope=offline,comment,vote,comment_option,custom_json',
        onPageStarted: (url) async {
          SharedPreferences prefs =
          await SharedPreferences.getInstance();

          var uri = Uri.parse(url.toString());
          uri.queryParameters.forEach((key, value) {
            if (key == 'access_token' ||
                key == 'username' ||
                key == 'code') {
              if (key == 'username' &&
                  prefs.getString('access_token') != null &&
                  prefs.getString('code') != null) {
                prefs.setString('HiveUserName', value);
              } else {
                prefs.setString(key, value);
              }
              hiveAuth(context);
            }
          });
        },
      ),
    );

  }
}
