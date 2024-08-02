import 'dart:typed_data';
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';

class shCard extends StatefulWidget{
@override
State<StatefulWidget> createState() => cardState();
}
class cardState extends State<shCard>{
  late Uint8List _imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Screenshot(
              controller: screenshotController,
              child: shardcard(),
            ),
          ),
          ElevatedButton(onPressed: () async {
          var image = await screenshotController.captureFromWidget(shardcard());
           await Gal.putImageBytes(image);
          print("pressed");
          }, child: Text("capture"))
        ],
      )
    );
    
  }
}

class shardcard extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 600,
        width: 400,
        child: Container(
          
          child: Stack(
            children: [Blur( blur: 10,
              blurColor: Colors.transparent,child: Container(child: Image.asset('assets/background.jpg',fit: BoxFit.fitHeight,height: 1000,width: 1000,))),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(child: Text("a way of exit or entrance : a road, path, channel, or course by which something passes. Special ships clear passages through the ice. nasal passages. b. : a corridor or lobby giving access to the different rooms or parts of a building or apartment",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),),
              )
          ], ),
        ),
      ),
    );
  }
}


