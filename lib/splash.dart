import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:practice/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class splash extends StatefulWidget {
  static SharedPreferences? pref;

  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _first1State();
}

class _first1State extends State<splash> {
  bool login = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getshare();
  }

  getshare() async {
    splash.pref = await SharedPreferences.getInstance();

    setState(() {
      login = splash.pref!.getBool("loginstatus") ?? false;
    });

    Future.delayed(Duration(seconds: 10)).then((value) {

      if (login)
      {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return home1();
          },
        ));

      }
      else
      {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return first();
          },
        ));
      }

    }) ;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Container(
              height: 200,
              width: 300,
              child: Lottie.asset("animation/ani.json",fit: BoxFit.fitHeight)
            ),
          )),
    );
  }
}



