import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:timer/primaryComponents/timer.dart' as timerWidget;
import 'package:timer/primaryComponents/stopwatch.dart' as stopwatchWidget;

import 'package:timer/secondaryComponents/duration.dart';
import 'package:timer/secondaryComponents/durationPicker.dart';

//days, hours, minutes, seconds, milliseconds, microseconds

void main() {
  //Force App In Portrait Mode
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
  Widget build(BuildContext context) {
    List timeLeftList =
        getFormattedDuration(widget.timer.functions.getTimeLeft());

    String timeLeftString = getStringFromFormattedDuration(timeLeftList);
    String timePassedSting =
        getStringFromDuration(widget.timer.functions.getTimePassed());
    String originalTimeString =
        getStringFromDuration(widget.timer.functions.getOriginalTime());

    return new Scaffold(
      key: _timerKey,
      body: new Stack(
        children: <Widget>[
          new Container(
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
                    new RaisedButton(
                        onPressed: () {
                          setState(() {
                            if (widget.timer.functions.isRunning())
                              widget.timer.functions.stop();
                            else
                              widget.timer.functions.start();
                          });
                        },
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            (widget.timer.functions.isRunning())
                                ? Icon(Icons.stop)
                                : Icon(Icons.play_arrow),
                            (widget.timer.functions.isRunning())
                                ? Text("Stop")
                                : Text("Start"),
                          ],
                        )),
                    new Container(
                      width: 16.0,
                      child: new Text(""),
                    ),
                    new RaisedButton(
                      //color: Theme.of(context).buttonColor,
                      onPressed: () {
                        setState(() {
                          widget.timer.functions.reset();
                        });
                      },
                      child: new Text("Reset"),
                    ),
                    new Expanded(
                        child: Container(
                      child: new Text(""),
                    )),
                  ],
                ),
                new Container(
                  width: 16.0,
                  child: new Text(""),
                ),
                new RaisedButton(
                  onPressed: () {
                    setState(() {
                      widget.timer.functions.set(
                        getRandomDuration(
                            randomSeconds: true,
                            randomMicroseconds: true,
                            randomMilliseconds: true),
                      );
                    });
                  },
                  child: new Text("Set to Random"),
                ),
                new GestureDetector(
                    onTap: () => print("Duration Picker Open"),
                    child: AnimatedWidget(
                      value: widget.timer.functions.getTimeLeft,
                      updateRecency: new Duration(
                          microseconds: ((1 / 60) * 1000 * 1000)
                              .round()), //60 updates per second
                    ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                      onPressed: () => showInSnackBar(
                            _timerKey,
                            "Original Time",
                            originalTimeString,
                          ),
                      child: new Text("Original Time"),
                    ),
                    new Text("="),
                    new FlatButton(
                      onPressed: () => showInSnackBar(
                            _timerKey,
                            "Time Passed",
                            timePassedSting,
                          ),
                      child: new Text("Time Passed"),
                    ),
                    new Text("+"),
                    new FlatButton(
                      onPressed: () => showInSnackBar(
                            _timerKey,
                            "Time Left",
                            timeLeftString,
                          ),
                      child: new Text("Time Left"),
                    ),
                  ],
                ),
              ],
            ),
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
  Widget build(BuildContext context) {
    List timePassedList =
        getFormattedDuration(widget.stopwatch.functions.getTimePassed());
    String timePassedString = getStringFromFormattedDuration(timePassedList);

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
                  new RaisedButton(
                      onPressed: () {
                        setState(() {
                          if (widget.stopwatch.functions.isRunning())
                            widget.stopwatch.functions.stop();
                          else
                            widget.stopwatch.functions.start();
                        });
                      },
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          (widget.stopwatch.functions.isRunning())
                              ? Icon(Icons.stop)
                              : Icon(Icons.play_arrow),
                          (widget.stopwatch.functions.isRunning())
                              ? Text("Stop")
                              : Text("Start"),
                        ],
                      )),
                  new Container(
                    width: 16.0,
                    child: new Text(""),
                  ),
                  new RaisedButton(
                    //color: Theme.of(context).buttonColor,
                    onPressed: () {
                      setState(() {
                        widget.stopwatch.functions.reset();
                      });
                    },
                    child: new Text("Reset"),
                  ),
                  new Expanded(
                      child: Container(
                    child: new Text(""),
                  )),
                ],
              ),
              new GestureDetector(
                onTap: () => print("Duration Picker Open"),
                child: AnimatedWidget(
                  value: widget.stopwatch.functions.getTimePassed,
                  updateRecency: new Duration(
                      microseconds: ((1 / 60) * 1000 * 1000).round()), //60 updates per second
                ),
              ),
              new FlatButton(
                onPressed: () => showInSnackBar(
                      _stopwatchKey,
                      "Time Passed",
                      timePassedString,
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

//-------------------------COMPONENTS-------------------------

class AnimatedWidget extends StatefulWidget {
  final Function value;
  final Duration updateRecency;

  AnimatedWidget({
    this.value,
    this.updateRecency,
  });

  @override
  _AnimatedWidgetState createState() => _AnimatedWidgetState();
}

class _AnimatedWidgetState extends State<AnimatedWidget> {
  @override
  void initState() {
    super.initState();
    autoUpdate();
  }

  autoUpdate() async {
    var prevValue;
    while (true) {
      await Future.delayed(widget.updateRecency);
      var currValue = widget.value();
      if (this.mounted && currValue != prevValue) {
        prevValue = currValue;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List timeShown = getFormattedDuration(widget.value());

    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TimeUnit(
          number: atleastLengthOfn(timeShown[0], 2),
          unit: "days",
        ),
        TimeSpacing(),
        TimeUnit(
          number: atleastLengthOfn(timeShown[1], 2),
          unit: "hours",
        ),
        TimeSpacing(),
        TimeUnit(
          number: atleastLengthOfn(timeShown[2], 2),
          unit: "minutes",
        ),
        TimeSpacing(),
        TimeUnit(
          number: atleastLengthOfn(timeShown[3], 2),
          unit: "seconds",
        ),
        TimeSpacing(),
        TimeUnit(
          number: atleastLengthOfn(timeShown[4], 3),
          unit: "milliseconds",
        ),
        TimeSpacing(),
        TimeUnit(
          number: atleastLengthOfn(timeShown[5], 3),
          unit: "microseconds",
        ),
      ],
    );
  }
}

class TimeSpacing extends StatelessWidget {
  const TimeSpacing({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(
        ":",
        style: TextStyle(
          fontSize: 32.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TimeUnit extends StatelessWidget {
  const TimeUnit({
    this.number,
    this.unit,
    Key key,
  }) : super(key: key);
  final String number;
  final String unit;
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.all(const Radius.circular(8.0)),
      ),
      child: new RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.bold,
            ),
            children: [
              new TextSpan(
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
                text: number,
              ),
              new TextSpan(text: "\n$unit"),
            ]),
      ),
    );
  }
}

//-------------------------OTHER-------------------------

String atleastLengthOfn(int num, int minLength) {
  String numStr = num.toString();
  int added0s = minLength - numStr.length;
  for (int i = added0s; i > 0; i--) numStr = "0" + numStr;
  return numStr;
}
