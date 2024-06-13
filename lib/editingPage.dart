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
      backgroundColor: HexColor(),
      appBar: AppBar(
        leading: IconButton(),
        actions: [
          IconButton(
            onPressed: () async {
              int count = await sql.getCount();
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
            color: HexColor(),
          ),
        ],
        backgroundColor: Colors.white,
      ),
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
                color: HexColor(hexColor))),
      ),
    );
    throw UnimplementedError();
  }
}
