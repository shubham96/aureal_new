import 'dart:io';

import 'package:auditory/domain/authentication/Hivesigner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  Widget loginWithHiveSigner(BuildContext context) {
    return InkWell(onTap: (){
      if(Platform.isIOS || Platform.isAndroid){
        Navigator.push(context, CupertinoPageRoute(builder: (context){
          return HiveAccount();
        }));

      }
    },child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.red), child: ListTile(minLeadingWidth: 0,leading: Image.asset('assets/images/hivesigner.png',cacheWidth: 100, width: 20,),title: const Text("HiveSigner",textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),trailing: const SizedBox(width: 20,),)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 1,child: Column(
            children: [
              Image.asset('assets/images/cut_piece.png'),
              Image.asset('assets/images/aureaText.png', width: MediaQuery.of(context).size.width / 2,)
            ],
          )),
          Expanded(flex: 2, child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
              loginWithHiveSigner(context),
              const SizedBox(height: 10,),
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: const Color(0xffFFFCF0)),child: ListTile(minLeadingWidth: 0,leading: Image.asset('assets/images/unstoppable.png', cacheWidth: 100, width: 20,),title: const Text("Unstoppable Domains",textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 15),),trailing: SizedBox(width: 20,))),
              const SizedBox(height: 10,),
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: const Color(0xffFFFCF0)),child: ListTile(leading: const Icon(FontAwesomeIcons.apple,color: Colors.black,),title: const Text("Login with Apple",textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 15),),trailing: SizedBox())),
              const SizedBox(height: 20,),
              Text("----------------------- or ------------------------"),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(backgroundColor: Colors.white,radius: 25,child: Image.asset('assets/images/google.png', width: 25,),),
                  CircleAvatar(backgroundColor: Colors.white, radius: 25,child: Image.asset('assets/images/twitter.png', width: 25,),),
                  CircleAvatar( radius: 25, backgroundImage: Image.asset("assets/images/keychain.png").image,),
                  CircleAvatar( radius: 25, backgroundImage: Image.asset("assets/images/discord.png").image,),
                ],
              )
            ],),
          ),)

        ],
      ),
    );
  }
}
