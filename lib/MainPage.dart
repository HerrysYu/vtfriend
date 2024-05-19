import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vtfriend/chatPage.dart';
import 'package:vtfriend/entryBar.dart';
import 'package:vtfriend/localdata.dart';
import 'package:vtfriend/main.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => chatPage()),
          );
        },
        child: Icon(Icons.note),
      ),
      body: StreamBuilder(
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
          }),
    );
    throw UnimplementedError();
  }
}
