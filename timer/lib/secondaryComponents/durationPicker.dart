import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'duration.dart';

import 'dart:math';

class DurationPicker extends StatelessWidget {
  final double pickerSize;
  final double pickerItemSize;
  final Duration initialDuration;
  final Function onConfirm;
  //---
  final TextStyle pickerTextStyle;

  DurationPicker({
    this.pickerSize: 99.9,
    this.pickerItemSize: 33.3,
    @required this.initialDuration,
    @required this.onConfirm,
    //---
    this.pickerTextStyle = const TextStyle(
      color: CupertinoColors.black,
      fontSize: 22.0,
    ),
  });

  int days; //365 max
  int hours; //23 max
  int minutes; //59 max
  int seconds; //59 max
  int milliseconds; //999 max
  int microseconds; //999 max

  getDuration() {
    return new Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
      microseconds: microseconds,
    );
  }

  @override
  Widget build(BuildContext context) {
    List formattedDuration = getFormattedDuration(initialDuration);
    days = formattedDuration[0];
    hours = formattedDuration[1];
    minutes = formattedDuration[2];
    seconds = formattedDuration[3];
    milliseconds = formattedDuration[4];
    microseconds = formattedDuration[5];

    Flexible pickerDays = new Flexible(
      child: new CupertinoPicker(
        scrollController: new FixedExtentScrollController(initialItem: days),
        itemExtent: pickerItemSize,
        backgroundColor: CupertinoColors.white,
        onSelectedItemChanged: (int index) => days = index,
        children: new List<Widget>.generate(100, (int index) {
          return new Center(
            child: new Text(atleastLengthOfn(index, 2)),
          );
        }),
      ),
    );

    Flexible pickerHours = new Flexible(
      child: new CupertinoPicker(
        scrollController: new FixedExtentScrollController(initialItem: hours),
        itemExtent: pickerItemSize,
        backgroundColor: CupertinoColors.white,
        onSelectedItemChanged: (int index) => hours = index,
        children: new List<Widget>.generate(24, (int index) {
          return new Center(
            child: new Text(atleastLengthOfn(index, 2)),
          );
        }),
      ),
    );

    Flexible pickerMinutes = new Flexible(
      child: new CupertinoPicker(
        scrollController: new FixedExtentScrollController(initialItem: minutes),
        itemExtent: pickerItemSize,
        backgroundColor: CupertinoColors.white,
        onSelectedItemChanged: (int index) => minutes = index,
        children: new List<Widget>.generate(60, (int index) {
          return new Center(
            child: new Text(atleastLengthOfn(index, 2)),
          );
        }),
      ),
    );

    Flexible pickerSeconds = new Flexible(
      child: new CupertinoPicker(
        scrollController: new FixedExtentScrollController(initialItem: seconds),
        itemExtent: pickerItemSize,
        backgroundColor: CupertinoColors.white,
        onSelectedItemChanged: (int index) => seconds = index,
        children: new List<Widget>.generate(60, (int index) {
          return new Center(
            child: new Text(atleastLengthOfn(index, 2)),
          );
        }),
      ),
    );

    Flexible pickerMilliseconds = new Flexible(
      child: new CupertinoPicker(
        scrollController:
            new FixedExtentScrollController(initialItem: milliseconds),
        itemExtent: pickerItemSize,
        backgroundColor: CupertinoColors.white,
        onSelectedItemChanged: (int index) => milliseconds = index,
        children: new List<Widget>.generate(1000, (int index) {
          return new Center(
            child: new Text(atleastLengthOfn(index, 3)),
          );
        }),
      ),
    );

    Flexible pickerMicroseconds = new Flexible(
      child: new CupertinoPicker(
        scrollController:
            new FixedExtentScrollController(initialItem: microseconds),
        itemExtent: pickerItemSize,
        backgroundColor: CupertinoColors.white,
        onSelectedItemChanged: (int index) => microseconds = index,
        children: new List<Widget>.generate(1000, (int index) {
          return new Center(
            child: new Text(atleastLengthOfn(index, 3)),
          );
        }),
      ),
    );

    return new GestureDetector(
      // Blocks Modal Sheet Behavior (hides slow animation as a cause of the heavy flutter picker code)
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      onVerticalDragStart: (DragStartDetails d) {},
      child: new DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.black,
        ),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              color: CupertinoColors.white,
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: new Stack(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new FlatButton(
                        onPressed: null,
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
                        onPressed: () => Navigator.pop(context),
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
                        onPressed: () => onConfirm(),
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
              color: CupertinoColors.destructiveRed,
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Expanded(
                    child: new Container(
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: new Text("days"),
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: new Text("hours"),
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: new Text("minutes"),
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: new Text("seconds"),
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: new Text("millisecs"),
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: new Text("microsecs."),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              height: pickerSize,
              child: new DefaultTextStyle(
                style: pickerTextStyle,
                child: new Row(
                  children: <Widget>[
                    pickerDays,
                    pickerHours,
                    pickerMinutes,
                    pickerSeconds,
                    pickerMilliseconds,
                    pickerMicroseconds,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
