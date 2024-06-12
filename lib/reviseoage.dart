import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vtfriend/localdata.dart';
import 'package:vtfriend/MainPage.dart';
import 'package:vtfriend/main.dart';

TextEditingController textEditingController_revisepage =
    new TextEditingController();

class revising extends StatelessWidget {
  String content;
  int day;
  int month;
  int year;
  int id;
  revising(
      {required this.content,
      required this.day,
      required this.month,
      required this.year,
      required this.id});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              int count = await sql.getCount();
              final now = DateTime.now();
              sql.updatejournals(journal(
                  content: textEditingController_revisepage.text.toString(),
                  day: day,
                  year: year,
                  month: month,
                  id: id));
              currentJournal = await sql.journals();
              mainpageupdateStream.sink.add("update");
              Navigator.pop(context);
            },
            icon: Icon(Icons.save),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: textEditingController_revisepage,
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                hintText: 'Write something',
                border: InputBorder.none),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
    throw UnimplementedError();
  }
}
