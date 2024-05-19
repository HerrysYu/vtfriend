import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vtfriend/MainPage.dart';
import 'package:vtfriend/main.dart';

class entrybar extends StatelessWidget {
  String journal;
  int month;
  int id;
  int day;
  int year;
  entrybar(
      {required this.journal,
      required this.month,
      required this.day,
      required this.id,
      required this.year});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        width: 400,
        child: GestureDetector(
          onDoubleTap: () async {
            print("current id=" + id.toString());
            sql.deletejournal(id);
            currentJournal = await sql.journals();
            mainpageupdateStream.add("updated");
          },
          child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 500),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    year.toString() +
                        '/' +
                        month.toString() +
                        '/' +
                        day.toString() +
                        ' :  ' +
                        journal,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 50,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
