import 'package:flutter/material.dart';
import 'package:vtfriend/chatPage.dart';
import 'package:vtfriend/testpage.dart';
import 'chatPage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: testPage()),
    );
  }
}
