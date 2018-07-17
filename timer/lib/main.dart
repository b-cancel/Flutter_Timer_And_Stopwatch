import 'package:flutter_picker/flutter_picker.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_picker/Picker.dart';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_picker/flutter_picker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String stateText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Picker'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.topCenter,
        child: new Column(
          children: <Widget>[
            (stateText != null) ? Text(stateText) : Container(),
            RaisedButton(
              child: Text('Picker Show'),
              onPressed: () {
                showPicker(context);
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('Picker Show Modal'),
              onPressed: () {
                showPickerModal(context);
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('Picker Show Icons'),
              onPressed: () {
                showPickerIcons(context);
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('Picker Show Dialog'),
              onPressed: () {
                showPickerDialog(context);
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('Picker Show Date'),
              onPressed: () {
                showPickerDate(context);
              },
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('Picker Show Datetime'),
              onPressed: () {
                showPickerDateTime(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  showPicker(BuildContext context) {
    Picker<String> picker = new Picker(
        pickerdata: new JsonDecoder().convert(PickerData),
        changeToFirst: true,
        textAlign: TextAlign.left,
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
        }
    );
    picker.show(_scaffoldKey.currentState);
  }

  showPickerModal(BuildContext context) {
    new Picker<String>(
        pickerdata: new JsonDecoder().convert(PickerData),
        changeToFirst: true,
        hideHeader: false,
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.adapter.text);
        }
    ).showModal(_scaffoldKey.currentState);
  }

  showPickerIcons(BuildContext context) {
    new Picker(
        data: [
          new PickerItem(text: Icon(Icons.add), value: Icons.add, children: [
            new PickerItem(text: Icon(Icons.more)),
            new PickerItem(text: Icon(Icons.aspect_ratio)),
            new PickerItem(text: Icon(Icons.android)),
            new PickerItem(text: Icon(Icons.menu)),
          ]),
          new PickerItem(text: Icon(Icons.title), value: Icons.title, children: [
            new PickerItem(text: Icon(Icons.more_vert)),
            new PickerItem(text: Icon(Icons.ac_unit)),
            new PickerItem(text: Icon(Icons.access_alarm)),
            new PickerItem(text: Icon(Icons.account_balance)),
          ]),
          new PickerItem(text: Icon(Icons.face), value: Icons.face, children: [
            new PickerItem(text: Icon(Icons.add_circle_outline)),
            new PickerItem(text: Icon(Icons.add_a_photo)),
            new PickerItem(text: Icon(Icons.access_time)),
            new PickerItem(text: Icon(Icons.adjust)),
          ]),
          new PickerItem(text: Icon(Icons.linear_scale), value: Icons.linear_scale, children: [
            new PickerItem(text: Icon(Icons.assistant_photo)),
            new PickerItem(text: Icon(Icons.account_balance)),
            new PickerItem(text: Icon(Icons.airline_seat_legroom_extra)),
            new PickerItem(text: Icon(Icons.airport_shuttle)),
            new PickerItem(text: Icon(Icons.settings_bluetooth)),
          ]),
          new PickerItem(text: Icon(Icons.close), value: Icons.close),
        ],
        title: new Text("Select Icon"),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
        }
    ).show(_scaffoldKey.currentState);
  }

  showPickerDialog(BuildContext context) {
    new Picker<String>(
        pickerdata: new JsonDecoder().convert(PickerData),
        hideHeader: true,
        title: new Text("Select Data"),
        onConfirm: (Picker picker, List value) {
          print(value.toString());
        }
    ).showDialog(context);
  }

  showPickerDate(BuildContext context) {
    new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(),
        title: new Text("Select Data"),
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).value);
        }
    ).showDialog(context);
  }

  showPickerDateTime(BuildContext context) {
    new Picker(
        adapter: new DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD_AP_HM,
            isNumberMonth: true,
            strAMPM: const["上午", "下午"],
            year_suffix: "年",
            month_suffix: "月",
            day_suffix: "日"
        ),
        title: new Text("Select DateTime"),
        onConfirm: (Picker picker, List value) {
          print(picker.adapter.text);
        },
        onSelect: (Picker picker, int index, List<int> selecteds) {
          this.setState(() {
            stateText = picker.adapter.toString();
            print("state text" + stateText);
          });
        }
    ).show(_scaffoldKey.currentState);
  }



}

const PickerData = '''
[
    {
        "a": [
            {
                "a1": [
                    1,
                    2,
                    3,
                    4
                ]
            },
            {
                "a2": [
                    5,
                    6,
                    7,
                    8
                ]
            },
            {
                "a3": [
                    9,
                    10,
                    11,
                    12
                ]
            }
        ]
    },
    {
        "b": [
            {
                "b1": [
                    11,
                    22,
                    33,
                    44
                ]
            },
            {
                "b2": [
                    55,
                    66,
                    77,
                    88
                ]
            },
            {
                "b3": [
                    99,
                    1010,
                    1111,
                    1212
                ]
            }
        ]
    },
    {
        "c": [
            {
                "c1": [
                    "a",
                    "b",
                    "c"
                ]
            },
            {
                "c2": [
                    "aa",
                    "bb",
                    "cc"
                ]
            },
            {
                "c3": [
                    "aaa",
                    "bbb",
                    "ccc"
                ]
            }
        ]
    }
]
    ''';

/*
import 'dart:async';

import 'package:flutter/material.dart';

import 'timer.dart' as timerWidget;
import 'stopwatch.dart' as stopwatchWidget;
import 'duration.dart';

//days, hours, minutes, seconds, milliseconds, microseconds

void main() => runApp(
      new MaterialApp(
        title: "Timer and Stopwatch",
        theme: ThemeData.dark(),
        home: new MainApp(),
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

  autoUpdateUI() async {
    int updatesPerSecond =
        60; //60 is the max that will make any visual difference
    while (true) {
      int millisecondsToWait = ((1 / updatesPerSecond) * 1000).round();
      await Future.delayed(new Duration(
          milliseconds:
              millisecondsToWait)); //wait some time before updating our UI
      if (this.mounted) setState(() {}); //update our UI based on our timer
    }
  }

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
      body: new Container(
          alignment: Alignment.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Expanded(child: Container(child: new Text(""),)),
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
                  new Expanded(child: Container(child: new Text(""),)),
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
                            randomMilliseconds: true
                        ),
                    );
                  });
                },
                child: new Text("Set to Random"),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TimeUnit(
                    number: atleastLengthOfn(timeLeftList[0], 2),
                    unit: "days",
                  ),
                  TimeSpacing(),
                  TimeUnit(
                    number: atleastLengthOfn(timeLeftList[1], 2),
                    unit: "hours",
                  ),
                  TimeSpacing(),
                  TimeUnit(
                    number: atleastLengthOfn(timeLeftList[2], 2),
                    unit: "minutes",
                  ),
                  TimeSpacing(),
                  TimeUnit(
                    number: atleastLengthOfn(timeLeftList[3], 2),
                    unit: "seconds",
                  ),
                  TimeSpacing(),
                  TimeUnit(
                    number: atleastLengthOfn(timeLeftList[4], 3),
                    unit: "milliseconds",
                  ),
                  TimeSpacing(),
                  TimeUnit(
                    number: atleastLengthOfn(timeLeftList[5], 3),
                    unit: "microseconds",
                  ),
                ],
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
          )),
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

  autoUpdateUI() async {
    int updatesPerSecond =
        60; //60 is the max that will make any visual difference
    while (true) {
      int millisecondsToWait = ((1 / updatesPerSecond) * 1000).round();
      await Future.delayed(new Duration(
          milliseconds:
              millisecondsToWait)); //wait some time before updating our UI
      if (this.mounted) setState(() {}); //update our UI based on our timer
    }
  }

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
                  new Expanded(child: Container(child: new Text(""),)),
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
                  new Expanded(child: Container(child: new Text(""),)),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TimeUnit(
                    number: atleastLengthOfn(timePassedList[0], 2),
                    unit: "days",
                  ),
                  TimeSpacing(),
                  TimeUnit(
                    number: atleastLengthOfn(timePassedList[1], 2),
                    unit: "hours",
                  ),
                  TimeSpacing(),
                  TimeUnit(
                    number: atleastLengthOfn(timePassedList[2], 2),
                    unit: "minutes",
                  ),
                  TimeSpacing(),
                  TimeUnit(
                    number: atleastLengthOfn(timePassedList[3], 2),
                    unit: "seconds",
                  ),
                  TimeSpacing(),
                  TimeUnit(
                    number: atleastLengthOfn(timePassedList[4], 3),
                    unit: "milliseconds",
                  ),
                  TimeSpacing(),
                  TimeUnit(
                    number: atleastLengthOfn(timePassedList[5], 3),
                    unit: "microseconds",
                  ),
                ],
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
  key.currentState.showSnackBar(new SnackBar(
      content: new RichText(
          text: new TextSpan(children: [
    new TextSpan(
      text: message,
    ),
    new TextSpan(
      text: value,
    ),
  ]))));
}

//-------------------------COMPONENTS-------------------------

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
*/
