import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrewButton extends StatefulWidget {
  @override
  _BrewButtonState createState() => _BrewButtonState();
}

class _BrewButtonState extends State<BrewButton> {
  double touchedWidth = 210;
  double touchedHeight = 50;
  double brewProgress = 0;
  bool coffeeStarted = false;
  int cupsOfCoffee = 2;

  void startBrew(){
    setState(() {
      coffeeStarted = true;
      touchedWidth = 265;
      touchedHeight = 118;
    });
    Timer.periodic(Duration(milliseconds: 400), (timer) {
      if(brewProgress >= 1)
        timer.cancel();
      else
        setState(() {
          brewProgress += 0.01;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: touchedWidth,
      curve: Curves.fastOutSlowIn,
      height: touchedHeight,
      duration: Duration(milliseconds: 600),
      child: coffeeStarted ?
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10, top: 10),
                  child: Text("Brewing $cupsOfCoffee Cups of Coffee",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 2 ),
                  child: Text("Well notify you when your coffee has finished brewing.",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor.withOpacity(.65),
                      fontSize: 14
                    )),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5)
                  ),
                  width: 200,
                  height: 3,
                  margin: EdgeInsets.only(top: 5),
                  child: LinearProgressIndicator(
                    value: brewProgress,
                    backgroundColor: Colors.transparent,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text("Cancel",
                    style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor)),
                )
              ],
            ),
          ) :
      OutlineButton(
        splashColor: Colors.white,
        borderSide: new BorderSide(color: Theme.of(context).primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          child: Text("Start Coffee Brew",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18
            ),
          ),
        ), onPressed: () {startBrew();},
      ),
    );
  }
}
