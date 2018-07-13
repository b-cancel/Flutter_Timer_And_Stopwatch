import 'dart:async';

import 'package:flutter/material.dart';

import 'timer.dart' as timerWidget;

//days, hours, minutes, seconds, milliseconds, microseconds

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {

  timerWidget.Timer timer = new timerWidget.Timer();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Stack(
          children: <Widget>[
            timer,
            TimerUI(
              timer: timer,
            ),
          ],
        ),
    );
  }
}

class TimerUI extends StatefulWidget {

  final timerWidget.Timer timer;

  TimerUI({
    @required this.timer,
  });

  @override
  _TimerUIState createState() => _TimerUIState();
}

class _TimerUIState extends State<TimerUI> {

  @override
  void initState() {
    super.initState();
    autoUpdateUI();
  }


  autoUpdateUI() async{
    int updatesPerSecond = 60; //60 is the max that will make any visual difference
    while(true){
      int millisecondsToWait = ((1/updatesPerSecond) * 1000).round();
      await Future.delayed(new Duration(milliseconds: millisecondsToWait)); //wait some time before updating our UI
      setState(() {}); //update our UI based on our timer
    }
  }

  @override
  Widget build(BuildContext context) {

    String theString = widget.timer.functions.getTimeLeft().toString();

    return new Scaffold(
      body: new Container(
          alignment: Alignment.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(theString),
              new FlatButton(
                onPressed: (){
                  setState(() {
                    widget.timer.functions.set(new Duration(seconds: 10));
                  });
                },
                child: new Text("Set to 10 seconds"),
              ),
              new FlatButton(
                onPressed: (){
                  setState(() {
                    widget.timer.functions.set(new Duration(seconds: 20));
                  });
                },
                child: new Text("Set to 20 seconds"),
              ),
              new FlatButton(
                onPressed: (){
                  setState(() {
                    widget.timer.functions.set(new Duration(seconds: 30));
                  });
                },
                child: new Text("Set to 30 seconds"),
              ),
              new FlatButton(
                onPressed: (){
                  setState(() {
                    widget.timer.functions.start();
                  });
                },
                child: new Text("start"),
              ),
              new FlatButton(
                onPressed: (){
                  setState(() {
                    widget.timer.functions.stop();
                  });
                },
                child: new Text("stop"),
              ),
              new FlatButton(
                onPressed: (){
                  setState(() {
                    widget.timer.functions.reset();
                  });
                },
                child: new Text("reset"),
              ),
            ],
          )
      ),
    );
  }
}