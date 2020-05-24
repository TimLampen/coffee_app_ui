import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NameAndTime extends StatefulWidget {
  final String name;

  NameAndTime({Key key, this.name}) : super(key: key);


  @override
  _NameAndTimeState createState() => _NameAndTimeState();

}

class _NameAndTimeState extends State<NameAndTime> {
  Timer timer;
  DateTime date = DateTime.now();
  final DateFormat dayFormat = new DateFormat("EEEE MMMM dd");
  final DateFormat timeFormat = new DateFormat("h:m a");

  String getDaySuffix(){
    switch(date.day){
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  @override
  void initState(){
    super.initState();
    date = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(date.minute != DateTime.now().minute)
        setState(() {
          date = DateTime.now();
        });
    });
  }

  @override
  void dispose(){
    super.dispose();
    timer.cancel();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 20, top: 20),
          child: Text("Good Morning, ${widget.name}",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 20),
          child: Text("${dayFormat.format(date)}${getDaySuffix()}",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 20),
          child: Text("${timeFormat.format(date)}",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}