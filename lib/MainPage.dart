import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vtfriend/chatPage.dart';
import 'package:vtfriend/entryBar.dart';
import 'package:vtfriend/localdata.dart';
import 'package:vtfriend/main.dart';
import 'package:flutter_launcher_icons/abs/icon_generator.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/config/config.dart';
import 'package:flutter_launcher_icons/config/macos_config.dart';
import 'package:flutter_launcher_icons/config/web_config.dart';
import 'package:flutter_launcher_icons/config/windows_config.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/logger.dart';
import 'package:flutter_launcher_icons/macos/macos_icon_generator.dart';
import 'package:flutter_launcher_icons/macos/macos_icon_template.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/pubspec_parser.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/web/web_icon_generator.dart';
import 'package:flutter_launcher_icons/web/web_template.dart';
import 'package:flutter_launcher_icons/windows/windows_icon_generator.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

class mainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

List<journal> currentJournal = [];

StreamController mainpageupdateStream = new StreamController.broadcast();
journalupdate() async {
  currentJournal = await sql.journals();
}

class MainPageState extends State<mainPage> {
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#232946"),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          elevation: 10,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => chatPage(), fullscreenDialog: true),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: HexColor("#eebbc3"),
          heroTag: 'fab',
        ),
        body: FutureBuilder(
            future: journalupdate(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return StreamBuilder(
                  stream: mainpageupdateStream.stream,
                  builder: (context, snapshot) {
                    return ListView(
                      children: [
                        for (var item in currentJournal)
                          entrybar(
                              journal: item.content,
                              month: item.month,
                              day: item.day,
                              id: item.id,
                              year: item.year)
                      ],
                    );
                  });
            }));
    throw UnimplementedError();
  }
}
