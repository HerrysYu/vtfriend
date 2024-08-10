import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gal/gal.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vtfriend/editingPage.dart';
import 'package:vtfriend/main.dart';

class shCard extends StatefulWidget{
final String journaltext;
shCard({required this.journaltext});
@override
State<StatefulWidget> createState() => cardState();
}
double val=0;
double blurval=0;
FontWeight fontWeight=FontWeight.normal;
class cardState extends State<shCard>{
  late Uint8List _imageFile;
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  int indexvalue=2;
  int slectedvalue=2;
  double fontsize=20;
  String assetaddress="assets/background0.jpg";
  var duration=Duration(milliseconds: 1000);
 var imageSaved = SnackBar(
  content: Text('Image have been saved to your gallery'),
);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(leading:IconButton(icon: Icon(Icons.last_page,color: Colors.white,size: 30,),onPressed: (){
        Navigator.pop(context);
      },),actions: [IconButton(onPressed: ()async{
        _imageFile = await screenshotController.captureFromWidget(journalcard( assetaddress: assetaddress, widget: widget, fontsize: fontsize));
        ImageGallerySaver.saveImage(_imageFile);
        ScaffoldMessenger.of(context).showSnackBar(imageSaved);
      }, icon: Icon(Icons.save,size:25,color:Colors.white),)],backgroundColor: Colors.transparent,),
      backgroundColor: HexColor("#232946"),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: Container(decoration:  BoxDecoration(boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 20,
          offset: Offset(-1, 1),
        )]), child: journalcard(assetaddress: assetaddress, widget: widget, fontsize: fontsize)),
            ),
          ),
          <Widget>[Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: SizedBox(
                width: 400,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 22,
                      offset: Offset(-1, 1),
                    )
                  ]),
                      clipBehavior:Clip.hardEdge,
                      child: SliderTheme(
                        data:SliderThemeData(trackHeight: 55,trackShape: RectangularSliderTrackShape(),thumbShape: SliderComponentShape.noThumb,overlayShape:SliderComponentShape.noOverlay,activeTrackColor:HexColor("#eebbc3"),inactiveTrackColor:HexColor("#f7d0d3")),
                        child: Slider(value: val, min:0,max:20,onChanged: (newValue){
                          setState(() {
                            val=newValue;
                            blurval=val;      
                          });
                        }),
                      ),
                    ),
                    Center(
                      child: Padding(
                      padding: const EdgeInsets.only(left: 0,top: 12,bottom: 0),
                      child: Text('Blur:${blurval.round()}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                        ),
                    )
                  ],
                ),
              ),
            ),
          ),Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 100,
                width: 500,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 8,bottom:8,left: 1,right: 1),child: SizedBox(height:100,width:100,child: GestureDetector(onTap: (){
                      setState(() {
                        assetaddress="assets/background0.jpg";
                      });
                    }, child: Image.asset('assets/background0.jpg',)),),),
                    Padding(padding: EdgeInsets.only(top: 8,bottom:8,left:1,right: 1),child: SizedBox(height:100,width:100,child: GestureDetector(onTap: (){
                      setState(() {
                        assetaddress="assets/background1.jpg";
                      });
                    }, child: Image.asset('assets/background1.jpg')),),),
                    Padding(padding: EdgeInsets.only(top: 8,bottom: 8,left: 1,right: 1),child: SizedBox(height:100,width:100,child: GestureDetector(onTap: (){
                      setState(() {
                        assetaddress="assets/background2.jpg";
                      });
                    }, child: Image.asset('assets/background2.jpg')),),),
                    Padding(padding: EdgeInsets.only(top: 8,bottom: 8,left: 1,right: 1),child: SizedBox(height:100,width:100,child: GestureDetector(onTap: (){
                      setState(() {
                        assetaddress="assets/background3.jpg";
                      });
                    }, child: Image.asset('assets/background3.jpg')),),),
                    Padding(padding: EdgeInsets.only(top: 8,bottom: 8,left: 1,right: 1),child: SizedBox(height:100,width:100,child: GestureDetector(onTap: (){
                      setState(() {
                        assetaddress="assets/background4.jpg";
                      });
                    }, child: Image.asset('assets/background4.jpg')),),),
                    Padding(padding: EdgeInsets.only(top: 8,bottom: 8,left: 1,right: 1),child: SizedBox(height:100,width:100,child: GestureDetector(onTap:(){
                      setState(() {
                        assetaddress="assets/background5.jpg";
                      });
                    }, child: Image.asset('assets/background5.jpg')),),),
                  ],
                ),
              ),
            ),
          ),Center(
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 10,top: 30),
                child: Stack(
                  children:[
                    Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: Offset(-1, 1),
                    )]
                      
                    ),
                    child: SliderTheme(data: SliderThemeData(trackHeight: 55,trackShape: RectangularSliderTrackShape(),thumbShape: SliderComponentShape.noThumb,overlayShape: SliderComponentShape.noOverlay,inactiveTrackColor: HexColor('#f7d0d3'),activeTrackColor: HexColor("#eebbc3")), child: Slider(min:10,max:30,value: fontsize.toDouble(),onChanged: (value){
                      setState(() {
                        fontsize=value;
                      });
                    },)),
                  ),
                  Center(child: Padding(
                    padding: const EdgeInsets.only(left: 22,top: 15,bottom: 15),
                    child: Text('fontsize:${fontsize.round()}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  ))
                  ]
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 10,top:30),
                child: Container(
                  decoration: BoxDecoration(color: HexColor('#eebbc3'),borderRadius: BorderRadius.all(Radius.circular(10)),boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: Offset(-1, 1),
                    )]),
                  child: DropdownMenu(dropdownMenuEntries: <DropdownMenuEntry<FontWeight>>[
                    DropdownMenuEntry(value: FontWeight.bold,labelWidget:Text('bold',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)), label: 'bold'),
                    DropdownMenuEntry(value: FontWeight.normal, label: 'normal',labelWidget: Text('normal',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15))),
                    DropdownMenuEntry(value: FontWeight.w100, label: 'w100',labelWidget: Text('w100',style: TextStyle(fontWeight: FontWeight.w100,fontSize: 15))),
                    DropdownMenuEntry(value: FontWeight.w500, label: 'w500',labelWidget: Text('w500',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15))),
                    DropdownMenuEntry(value: FontWeight.w900, label: 'w900',labelWidget: Text('w900',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15))),
                  ],leadingIcon: Icon(Icons.line_axis),
                  hintText: 'Weight',
                  onSelected: (value){
                    setState(() {
                      fontWeight=value!;
                    });
                  },
                                 menuStyle: MenuStyle(elevation: WidgetStateProperty.all(10),
                                 visualDensity: VisualDensity(horizontal: 0),
                                 backgroundColor: WidgetStateProperty.all(HexColor("#eebbc3"))),
                                 textStyle: TextStyle(fontWeight: FontWeight.bold),
                                 requestFocusOnTap: true,
                                 inputDecorationTheme: InputDecorationTheme(border: InputBorder.none,),),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,),
          )][slectedvalue]
        ],  
      ),
      bottomNavigationBar: Theme(
         data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          enableFeedback: true,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: HexColor('#b8c1ec'),
          backgroundColor: HexColor('#232946'),
          selectedItemColor: HexColor('#eebbc3'),
          elevation: 20,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.blur_circular,size: 30,),label: 'Blur',),
            BottomNavigationBarItem(icon: Icon(Icons.image,size: 30,),label: 'Background'),
            BottomNavigationBarItem(icon: Icon(Icons.font_download,size: 30,),label: 'Font'),
          ],
          currentIndex: indexvalue,
          onTap: (value) {
            setState(() {
              indexvalue=value;
              slectedvalue=value;
            });
          },
        ),
      ),
    );
    
  }
}

class journalcard extends StatefulWidget {
  const journalcard({
    required this.assetaddress,
    required this.widget,
    required this.fontsize,
  });

  final String assetaddress;
  final shCard widget;
  final double fontsize;

  @override
  State<journalcard> createState() => _journalcardState();
}

class _journalcardState extends State<journalcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
          child: SizedBox(
            height: 600,
            width: 400,
            child: Stack(
                    children: [Blur( blur: blurval,
                blurColor: Colors.transparent,child: Container(child: Image.asset(widget.assetaddress,fit: BoxFit.fill,height: 1000,width: 1000,))),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(child: Text(widget.widget.journaltext,style: TextStyle(fontSize: widget.fontsize.toDouble(),color: Colors.white,fontWeight: fontWeight),),),
                )
            ], ),
          ),
      );
  }
}

