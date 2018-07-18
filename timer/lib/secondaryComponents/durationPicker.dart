import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'duration.dart';

class DurationVars{
  DurationVars(){
    days = 365;
    hours = 23;
    minutes = 59;
    seconds = 59;
    milliseconds = 999;
    microseconds = 999;
  }
  int days;
  int hours;
  int minutes;
  int seconds;
  int milliseconds;
  int microseconds;
}

class DurationPicker extends StatelessWidget {

  final DurationVars vars = new DurationVars();
  final double _kPickerSheetHeight = 216.0;
  final double _kPickerItemHeight = 32.0;

  getDays() => vars.days;
  getHours() => vars.hours;
  getMinutes() => vars.minutes;
  getSeconds() => vars.seconds;
  getMilliseconds() => vars.milliseconds;
  getMicroseconds() => vars.microseconds;

  setDays(int value) => vars.days = value;
  setHours(int value) => vars.hours = value;
  setMinutes(int value) => vars.minutes = value;
  setSeconds(int value) => vars.seconds = value;
  setMilliseconds(int value) => vars.milliseconds = value;
  setMicroseconds(int value) => vars.microseconds = value;

  @override
  Widget build(BuildContext context) {
    return new DefaultTextStyle(
      style: TextStyle(
        color: CupertinoColors.black,
      ),
      child: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            color: CupertinoColors.white,
            child: new Stack(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text(
                        "Set New Duration",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text(" "),
                    new FlatButton(
                      onPressed: () => print("canceled"),
                      child: new Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new FlatButton(
                      onPressed: () => print("confirmed"),
                      child: new Text(
                        "Confirm",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    new Text(" "),
                  ],
                )
              ],
            ),
          ),
          new Container(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            color: CupertinoColors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text("days   "),
                new Text("hours  "),
                new Text("minutes"),
                new Text("seconds"),
                new Text("mil_secs"),
                new Text("mic_secs"),
              ],
            ),
          ),
          new Container(
            color: CupertinoColors.white,
            height: _kPickerSheetHeight,
            child: new DefaultTextStyle(
              style: const TextStyle(
                color: CupertinoColors.black,
                fontSize: 22.0,
              ),
              child: new GestureDetector(
                // Blocks taps from propagating to the modal sheet and popping.
                onTap: () {},
                child: new SafeArea(
                  child: new Row(
                    children: <Widget>[
                      new Flexible(
                        fit: FlexFit.loose,
                        child: new CupertinoPicker(
                          scrollController: new FixedExtentScrollController(initialItem: getDays()),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => setDays(index),
                          children: new List<Widget>.generate(366, (int index) {
                            return new Center(child:
                            new Text((index).toString()),
                            );
                          }),
                        ),
                      ),
                      new Flexible(
                        fit: FlexFit.tight,
                        child: new CupertinoPicker(
                          scrollController: new FixedExtentScrollController(initialItem: getHours()),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => setHours(index),
                          children: new List<Widget>.generate(24, (int index) {
                            return new Center(child:
                            new Text((index).toString()),
                            );
                          }),
                        ),
                      ),
                      new Flexible(
                        fit: FlexFit.tight,
                        child: new CupertinoPicker(
                          scrollController: new FixedExtentScrollController(initialItem: getMinutes()),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => setMinutes(index),
                          children: new List<Widget>.generate(60, (int index) {
                            return new Center(child:
                            new Text((index).toString()),
                            );
                          }),
                        ),
                      ),
                      new Flexible(
                        fit: FlexFit.tight,
                        child: new CupertinoPicker(
                          scrollController: new FixedExtentScrollController(initialItem: getSeconds()),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => setSeconds(index),
                          children: new List<Widget>.generate(60, (int index) {
                            return new Center(child:
                            new Text((index).toString()),
                            );
                          }),
                        ),
                      ),
                      new Flexible(
                        fit: FlexFit.tight,
                        child: new CupertinoPicker(
                          scrollController: new FixedExtentScrollController(initialItem: getMilliseconds()),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => setMilliseconds(index),
                          children: new List<Widget>.generate(1000, (int index) {
                            return new Center(child:
                            new Text((index).toString()),
                            );
                          }),
                        ),
                      ),
                      new Flexible(
                        fit: FlexFit.tight,
                        child: new CupertinoPicker(
                          scrollController: new FixedExtentScrollController(initialItem: getMicroseconds()),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => setMicroseconds(index),
                          children: new List<Widget>.generate(1000, (int index) {
                            return new Center(child:
                            new Text((index).toString()),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}