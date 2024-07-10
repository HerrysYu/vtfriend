import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
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
  String id;
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
      backgroundColor: HexColor("#232946"),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.exit_to_app),
          color: HexColor("#eebbc3"),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              String count = await sql.Gid();
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
            color: HexColor("#eebbc3"),
          ),
        ],
        backgroundColor: Colors.transparent,
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
                    color: Colors.white),
                hintText: 'Write something',
                border: InputBorder.none),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
    throw UnimplementedError();
  }
}
