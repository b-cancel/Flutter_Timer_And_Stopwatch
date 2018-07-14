import 'dart:async';

import 'package:flutter/material.dart';

import 'timer.dart' as timerWidget;
import 'stopwatch.dart' as stopwatchWidget;

//days, hours, minutes, seconds, milliseconds, microseconds

void main() => runApp(
  new MaterialApp(
    theme: ThemeData.dark(),
    home: new MainApp()
  ),
);

//-------------------------MAIN-------------------------

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _openTimer() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return TimerExample();
          },
        ),
      );
    }

    void _openStopwatch() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return StopwatchExample();
          },
        ),
      );
    }

    return new Scaffold(
      body: new Container(
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new RaisedButton(
              padding: EdgeInsets.all(8.0),
              onPressed: _openTimer,
              child: new Text(
                "Timer",
                style: new TextStyle(
                  fontSize: 48.0,
                ),
              ),
            ),
            new RaisedButton(
              padding: EdgeInsets.all(8.0),
              onPressed: _openStopwatch,
              child: new Text(
                "Stopwatch",
                style: new TextStyle(
                  fontSize: 48.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-------------------------TIMER EXAMPLE-------------------------

class TimerExample extends StatelessWidget {

  final timerWidget.Timer timer = new timerWidget.Timer();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Timer'),
      ),
      body: new Stack(
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
  final GlobalKey<ScaffoldState> _timerKey = new GlobalKey<ScaffoldState>();

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
      if(this.mounted) setState(() {}); //update our UI based on our timer
    }
  }

  @override
  Widget build(BuildContext context) {

    String theString = widget.timer.functions.getTimeLeft().toString();

    return new Scaffold(
      key: _timerKey,
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
              new Row(
                children: <Widget>[
                  new FlatButton(
                    onPressed: () => showInSnackBar(_timerKey, "Original Time", widget.timer.functions.getOriginalTime().toString()),
                    child: new Text("Original Time"),
                  ),
                  new Text("="),
                  new FlatButton(
                    onPressed: () => showInSnackBar(_timerKey, "Time Passed", widget.timer.functions.getTimePassed().toString()),
                    child: new Text("Time Passed"),
                  ),
                  new Text("+"),
                  new FlatButton(
                    onPressed: () => showInSnackBar(_timerKey, "Time Left", widget.timer.functions.getTimeLeft().toString()),
                    child: new Text("Time Left"),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}

//-------------------------STOPWATCH EXAMPLE-------------------------

class StopwatchExample extends StatelessWidget {

  final stopwatchWidget.Stopwatch stopwatch = new stopwatchWidget.Stopwatch();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: new Stack(
        children: <Widget>[
          stopwatch,
          StopwatchUI(
            stopwatch: stopwatch,
          ),
        ],
      ),
    );
  }
}

class StopwatchUI extends StatefulWidget {

  final stopwatchWidget.Stopwatch stopwatch;

  StopwatchUI({
    @required this.stopwatch,
  });

  @override
  _StopwatchUIState createState() => _StopwatchUIState();
}

class _StopwatchUIState extends State<StopwatchUI> {
  final GlobalKey<ScaffoldState> _stopwatchKey = new GlobalKey<ScaffoldState>();

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
      if(this.mounted) setState(() {}); //update our UI based on our timer
    }
  }

  @override
  Widget build(BuildContext context) {

    String theString = widget.stopwatch.functions.getTimePassed().toString();

    return new Scaffold(
      key: _stopwatchKey,
      body: new Container(
          alignment: Alignment.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(theString),
              new FlatButton(
                onPressed: (){
                  setState(() {
                    widget.stopwatch.functions.start();
                  });
                },
                child: new Text("start"),
              ),
              new FlatButton(
                onPressed: (){
                  setState(() {
                    widget.stopwatch.functions.stop();
                  });
                },
                child: new Text("stop"),
              ),
              new FlatButton(
                onPressed: (){
                  setState(() {
                    widget.stopwatch.functions.reset();
                  });
                },
                child: new Text("reset"),
              ),
              new FlatButton(
                onPressed: () => showInSnackBar(_stopwatchKey, "Time Passed", widget.stopwatch.functions.getTimePassed().toString()),
                child: new Text("Time Passed"),
              ),
            ],
          )
      ),
    );
  }
}

//-------------------------SNACKBAR-------------------------

showInSnackBar(GlobalKey<ScaffoldState> key, String message, String value) {
  key.currentState.showSnackBar(new SnackBar(
      content: new RichText(
          text: new TextSpan(
              children: [
                new TextSpan(
                  text: message,
                ),
                new TextSpan(
                  text: value,
                ),
              ]
          )
      )
  ));
}