import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:timer/primaryComponents/timer.dart' as timerWidget;
import 'package:timer/primaryComponents/stopwatch.dart' as stopwatchWidget;

import 'package:timer/secondaryComponents/duration.dart';
import 'package:timer/secondaryComponents/durationDisplay.dart';
import 'package:timer/secondaryComponents/durationPicker.dart';

void main() {
  //Force App In Portrait Mode
  /*
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  */

  //Run our App
  runApp(
    new MaterialApp(
      title: "Timer and Stopwatch",
      theme: ThemeData.dark(),
      home: new MainApp(),
    ),
  );
}

//-------------------------MAIN-------------------------

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: <Widget>[
              Tab(text: "Stopwatch"),
              Tab(text: "Timer"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            StopwatchExample(),
            TimerExample(),
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

  DurationPicker picker;

  final running = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    running.value = widget.timer.functions.isRunning();
    autoUpdate();
  }

  autoUpdate() async {
    while (true) {
      await Future.delayed(new Duration(microseconds: 16666)); //60 times per second
      if(running.value != widget.timer.functions.isRunning())
        running.value = widget.timer.functions.isRunning();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _timerKey,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(
                child: Container(
                  child: new Text(""),
                ),
              ),
              new AnimatedBuilder(
                animation: running,
                builder: (context, child){
                  return new RaisedButton(
                    onPressed: () {
                      setState(() {
                        if (widget.timer.functions.isRunning())
                          widget.timer.functions.pause();
                        else
                          widget.timer.functions.play();
                      });
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        (widget.timer.functions.isRunning())
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
                        (widget.timer.functions.isRunning())
                            ? Text("Pause")
                            : Text("Play"),
                      ],
                    ),
                  );
                },
              ),
              new Container(
                width: 16.0,
                child: new Text(""),
              ),
              new RaisedButton(
                onPressed: () => widget.timer.functions.reset(),
                child: new Text("Reset"),
              ),
              new Expanded(
                child: Container(
                  child: new Text(""),
                ),
              ),
            ],
          ),
          new FlatButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  picker = new DurationPicker(
                    initialDuration: widget.timer.functions.getOriginalTime(),
                    onConfirm: () {
                      widget.timer.functions.set(picker.getDuration());
                      Navigator.pop(context);
                    },
                    onCancel: () => Navigator.pop(context),
                  );
                  return picker;
                },
              );
            },
            child: new Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: new DurationDisplay(
                value: widget.timer.functions.getTimeLeft,
              ),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlatButton(
                onPressed: () => showInSnackBar(
                  _timerKey,
                  "Original Time",
                  getStringFromDuration(
                      widget.timer.functions.getOriginalTime()),
                ),
                child: new Text("Original Time"),
              ),
              new Text("="),
              new FlatButton(
                onPressed: () => showInSnackBar(
                  _timerKey,
                  "Time Passed",
                  getStringFromDuration(
                      widget.timer.functions.getTimePassed()),
                ),
                child: new Text("Time Passed"),
              ),
              new Text("+"),
              new FlatButton(
                onPressed: () => showInSnackBar(
                  _timerKey,
                  "Time Left",
                  getStringFromDuration(
                      widget.timer.functions.getTimeLeft()),
                ),
                child: new Text("Time Left"),
              ),
            ],
          ),
        ],
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

  DurationPicker picker;

  final running = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    running.value = widget.stopwatch.functions.isRunning();
    autoUpdate();
  }

  autoUpdate() async {
    while (true) {
      await Future.delayed(new Duration(microseconds: 16666)); //60 times per second
      if(running.value != widget.stopwatch.functions.isRunning())
        running.value = widget.stopwatch.functions.isRunning();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _stopwatchKey,
      body: new Container(
          alignment: Alignment.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Expanded(
                      child: Container(
                    child: new Text(""),
                  )),
                  new AnimatedBuilder(
                    animation: running,
                    builder: (context, child){
                      return new RaisedButton(
                        onPressed: () {
                          setState(() {
                            if (widget.stopwatch.functions.isRunning())
                              widget.stopwatch.functions.pause();
                            else
                              widget.stopwatch.functions.play();
                          });
                        },
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            (widget.stopwatch.functions.isRunning())
                                ? Icon(Icons.pause)
                                : Icon(Icons.play_arrow),
                            (widget.stopwatch.functions.isRunning())
                                ? Text("Pause")
                                : Text("Play"),
                          ],
                        ),
                      );
                    },
                  ),
                  new Container(
                    width: 16.0,
                    child: new Text(""),
                  ),
                  new RaisedButton(
                    onPressed: () => widget.stopwatch.functions.reset(),
                    child: new Text("Reset"),
                  ),
                  new Expanded(
                      child: Container(
                    child: new Text(""),
                  )),
                ],
              ),
              new FlatButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      picker = new DurationPicker(
                        initialDuration:
                            widget.stopwatch.functions.getMaxTime(),
                        titleText: "Set Max Duration",
                        onConfirm: () {
                          widget.stopwatch.functions
                              .setMaxTime(picker.getDuration());
                          Navigator.pop(context);
                        },
                        onCancel: () => Navigator.pop(context),
                      );
                      return picker;
                    },
                  );
                },
                child: new Container(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: new DurationDisplay(
                    value: widget.stopwatch.functions.getTimePassed,
                  ),
                ),
              ),
              new FlatButton(
                onPressed: () => showInSnackBar(
                  _stopwatchKey,
                  "Time Passed",
                  getStringFromDuration(widget.stopwatch.functions.getTimePassed()),
                ),
                child: new Text("Time Passed"),
              ),
            ],
          )),
    );
  }
}

//-------------------------SNACKBAR-------------------------

showInSnackBar(GlobalKey<ScaffoldState> key, String message, String value) {
  key.currentState.showSnackBar(
    new SnackBar(
      content: new RichText(
        text: new TextSpan(
          children: [
            new TextSpan(
              text: message,
            ),
            new TextSpan(
              text: value,
            ),
          ],
        ),
      ),
    ),
  );
}