import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:vtfriend/MainPage.dart';
import 'package:vtfriend/chatPage.dart';
import 'package:vtfriend/localdata.dart';
import 'package:vtfriend/localdata.dart';
import 'package:vtfriend/passwordPage.dart';
import 'package:vtfriend/share.dart';
import 'package:vtfriend/shareCard.dart';
import 'package:vtfriend/testpage.dart';
import 'chatPage.dart';

void main() {
  runApp(MainApp());
}

final sqlhelper sql = new sqlhelper();

StreamController lockStream = new StreamController();

List LockPage = [mainPage(), passwordPage()];

int index = 0;

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    journalupdate();
    return MaterialApp(
      home: Scaffold(
          body: StreamBuilder(
               stream: lockStream.stream,
               builder: (context, snapshot) {
                return LockPage[index];
               })
              ),
    );
  }
}
