import 'package:flutter/material.dart';
import 'package:inoneboss/VerifyPage.dart';
import 'Home.dart';
import 'RegPage.dart';
import 'Splash.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/verify': (context) => VerifyPage(),
        '/home': (context) => Home(),
        '/login': (context) => RegPage(),
      },
      debugShowCheckedModeBanner: false,
    ));
