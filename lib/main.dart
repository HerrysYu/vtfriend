import 'package:flutter/material.dart';
import 'package:vtfriend/MainPage.dart';
import 'package:vtfriend/chatPage.dart';
import 'package:vtfriend/localdata.dart';
import 'package:vtfriend/localdata.dart';
import 'package:vtfriend/passwordPage.dart';
import 'package:vtfriend/testpage.dart';
import 'chatPage.dart';

void main() {
  runApp(MainApp());
}

final sqlhelper sql = new sqlhelper();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    journalupdate();
    return MaterialApp(
      home: Scaffold(body: mainPage()),
    );
  }
}
