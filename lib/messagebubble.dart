import 'package:bubble/bubble.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:vtfriend/chatPage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class messagebubble extends StatelessWidget {
  final bool isme;
  final String message;
  messagebubble({required this.isme, required this.message});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (isme == true) {
      return Padding(
        padding: const EdgeInsets.only(right: 8, top: 12, bottom: 12),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(
            child: Container(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 15, right: 15),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              )),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(-1, 3),
                    )
                  ],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
          SizedBox(
            height: 50,
            width: 0,
          )
        ]),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8, top: 12, bottom: 12),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 50,
            width: 0,
          ),
          SizedBox(
            child: Container(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 15, right: 15),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: Text(
                    softWrap: true,
                    message,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              )),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(-1, 3),
                    )
                  ],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ]),
      );
    }
    throw UnimplementedError();
  }
}
