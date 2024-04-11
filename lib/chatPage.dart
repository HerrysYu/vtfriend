import 'dart:async';
import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

StreamController ChatPageStream = new StreamController();
SocketConnectChat socketConnectChat = new SocketConnectChat();
List<chatmessageInfo> messageList = [];
ScrollController scrollController = new ScrollController();
String title = "聊天界面";

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
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: ChatPageStream.stream,
        builder: (context, snapshot) {
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    socketConnectChat.webSocketChannel.sink.close();
                  },
                ),
                title: Text(title),
              ),
              body: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 45, left: 20, right: 20),
                        child: ListView(children: [
                          for (var obj in messageList.reversed)
                            chatmessage(isgpt: obj.isgpt, content: obj.content)
                        ], controller: scrollController, reverse: true),
                      ),
                      messageBar()
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
        messageList.add(chatmessageInfo(isgpt: 0, content: message));
        socketConnectChat.webSocketChannel.sink.add(message);
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
  int isgpt;
  String content;
  chatmessage({required this.isgpt, required this.content});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build]
    if (isgpt == 0) {
      return Bubble(
        margin: BubbleEdges.only(top: 10),
        alignment: Alignment.topRight,
        nip: BubbleNip.rightBottom,
        color: Color.fromRGBO(212, 244, 218, 1),
        child: SizedBox(
          child: Text(content,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        ),
      );
    } else {
      return Bubble(
        margin: BubbleEdges.only(top: 10),
        alignment: Alignment.topLeft,
        nip: BubbleNip.leftBottom,
        color: Color.fromRGBO(212, 234, 244, 1.0),
        child: SizedBox(
          width: 220,
          child: Text(content,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      );
    }
    throw UnimplementedError();
  }
}

class chatmessageInfo {
  int isgpt;
  String content;
  chatmessageInfo({required this.isgpt, required this.content});
}

class SocketConnectChat {
  late WebSocketChannel webSocketChannel;
  Connect() {
    webSocketChannel =
        WebSocketChannel.connect(Uri.parse("ws://202.182.127.220:1212"));
    this.webSocketChannel.stream.listen((dynamic message) {
      if (message == "received") {
        title = "loading";
        ChatPageStream.add("");
      } else {
        title = "聊天界面";
        messageList.add(chatmessageInfo(isgpt: 1, content: message));
        ChatPageStream.add("");
      }
    });
  }
}
