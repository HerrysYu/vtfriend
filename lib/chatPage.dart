import 'dart:async';
import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:vtfriend/MainPage.dart';
import 'package:vtfriend/main.dart';
import 'package:vtfriend/messagebubble.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:vtfriend/messagesendbar.dart';
import 'package:vtfriend/editingPage.dart';

StreamController ChatPageStream = new StreamController.broadcast();
List<chatmessageInfo> messageList = [];
SocketConnectChat socketConnectChat = new SocketConnectChat();
ScrollController scrollController = new ScrollController();
String title = "AirNote";

class chatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => chatPageState();
}

class chatPageState extends State<chatPage> {
  @override
  void initState() {
    // TODO: implement initState
    socketConnectChat.Connect();
    super.initState();
  }

  @override
  void deactivate() {}

  @override
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: ChatPageStream.stream,
        builder: (context, snapshot) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    messageList = [];
                    Navigator.pop(context);
                    currentJournal = await sql.journals();
                    mainpageupdateStream.add("");
                  },
                ),
                title: Text(title),
              ),
              body: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 100, left: 20, right: 20),
                        child: ListView(children: [
                          for (var obj in messageList.reversed)
                            GestureDetector(
                                onLongPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => editting(
                                              content: obj.content,
                                            )),
                                  );
                                  textEditingController.text = obj.content;
                                },
                                child: chatmessage(
                                    isai: obj.isai, content: obj.content))
                        ], controller: scrollController, reverse: true),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: messagebar(
                              onsend: (message) {
                                messageList.add(
                                    chatmessageInfo(isai: 0, content: message));
                                title = "Loading";
                                ChatPageStream.add("");
                                socketConnectChat.webSocketChannel.sink
                                    .add(message);
                              },
                            ),
                          ))
                        ],
                      )
                    ],
                  )));
        });
    throw UnimplementedError();
  }
}

class messageBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MessageBar(
      onSend: (message) {
        messageList.add(chatmessageInfo(isai: 0, content: message));
        ChatPageStream.add("");
        // scrollController.position(scrollController)
      },
      actions: [
        InkWell(
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 24,
          ),
          onTap: () {},
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: InkWell(
            child: Icon(
              Icons.camera_alt,
              color: Colors.green,
              size: 24,
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class chatmessage extends StatelessWidget {
  int isai;
  String content;
  chatmessage({required this.isai, required this.content});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build]
    if (isai == 0) {
      return messagebubble(isme: true, message: content);
    } else {
      return messagebubble(isme: false, message: content);
    }
    throw UnimplementedError();
  }
}

class chatmessageInfo {
  int isai;
  String content;
  chatmessageInfo({required this.isai, required this.content});
}

class SocketConnectChat {
  late WebSocketChannel webSocketChannel;
  Connect() {
    webSocketChannel =
        WebSocketChannel.connect(Uri.parse("ws://192.168.1.11:1211"));
    this.webSocketChannel.stream.listen((dynamic message) {
      if (message == "received") {
        title = "loading";
        ChatPageStream.add("");
      } else {
        title = "AirNote";
        messageList.add(chatmessageInfo(isai: 1, content: message.toString()));
        ChatPageStream.add("");
      }
    });
  }
}
