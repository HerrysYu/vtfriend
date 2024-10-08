import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vtfriend/MainPage.dart';
import 'package:vtfriend/chatPage.dart';
import 'package:vtfriend/localdata.dart';
import 'package:vtfriend/main.dart';

TextEditingController textEditingController = new TextEditingController();

class editting extends StatelessWidget {
  String content;
  editting({
    required this.content,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset:true,
      backgroundColor: HexColor("#232946"),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.last_page),
            color: HexColor("#eebbc3"),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                String count = await sql.Gid();
                final now = DateTime.now();
                sql.InsertJournal(journal(
                    content: textEditingController.text.toString(),
                    day: now.day,
                    year: now.year,
                    month: now.month,
                    id: count));
                currentJournal = await sql.journals();
                mainpageupdateStream.add("");
                messageList = [];
                socketConnectChat.webSocketChannel.sink.close();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: Icon(Icons.save),
              color: HexColor("#eebbc3"),
            ),
          ],
          backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: textEditingController,
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