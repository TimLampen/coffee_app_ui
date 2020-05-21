import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NameAndTime extends StatefulWidget {
  final String name;

  TimeOfDay time = TimeOfDay.now();
  NameAndTime({Key key, this.name});


  @override
  _NameAndTimeState createState() => _NameAndTimeState();

  void updateTime
}

class _NameAndTimeState extends State<NameAndTime> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}