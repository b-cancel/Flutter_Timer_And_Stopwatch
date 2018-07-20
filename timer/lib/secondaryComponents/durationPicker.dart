import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'duration.dart';

import 'dart:math';

enum durationTimeType {
  days,
  hours,
  minutes,
  seconds,
  milliseconds,
  microseconds,
}

class DurationPicker extends StatelessWidget {
  //---functional params
  final Duration initialDuration;
  final Function onConfirm;
  final Function onCancel;
  //---switch params
  final bool showDays;
  final bool showHours;
  final bool showMinutes;
  final bool showSeconds;
  final bool showMilliseconds;
  final bool showMicroseconds;
  //---duration value sizes
  final int minDaySpaces;
  final int minHourSpaces;
  final int minMinuteSpaces;
  final int minSecondSpaces;
  final int minMillisecondSpaces;
  final int minMicrosecondSpaces;
  //---max duration values(exclusive)
  final int maxDaysExclusive;
  final int maxHoursExclusive;
  final int maxMinutesExclusive;
  final int maxSecondsExclusive;
  final int maxMillisecondsExclusive;
  final int maxMicrosecondsExclusive;
  //---min duration values(inclusive)
  final int minDaysInclusive;
  final int minHoursInclusive;
  final int minMinutesInclusive;
  final int minSecondsInclusive;
  final int minMillisecondsInclusive;
  final int minMicrosecondsInclusive;
  //---picker params
  final double pickerSize;
  final double pickerItemSize;
  final Color pickerBackgroundColor;
  final double pickerDiameterRatio;
  final TextStyle pickerTextStyle;
  //---label params
  final TextStyle labelTextStyle;
  final Color labelBackgroundColor;
  //---other params
  final Color topBarColor;
  final TextStyle titleTextStyle;
  final String titleText;
  final TextStyle buttonTextStyle;
  final String leftButtonText;
  final String rightButtonText;

  DurationPicker({
    //---functional params
    @required this.initialDuration,
    @required this.onConfirm,
    @required this.onCancel,
    //---functional switch params
    this.showDays: true,
    this.showHours: true,
    this.showMinutes: true,
    this.showSeconds: true,
    this.showMilliseconds: true,
    this.showMicroseconds: true,
    //---duration value sizes
    this.minDaySpaces: 2,
    this.minHourSpaces: 2,
    this.minMinuteSpaces: 2,
    this.minSecondSpaces: 2,
    this.minMillisecondSpaces: 3,
    this.minMicrosecondSpaces: 3,
    //---max duration values
    this.maxDaysExclusive: 100,
    this.maxHoursExclusive: 24,
    this.maxMinutesExclusive: 60,
    this.maxSecondsExclusive: 60,
    this.maxMillisecondsExclusive: 1000,
    this.maxMicrosecondsExclusive: 1000,
    //---min duration values
    this.minDaysInclusive: 0,
    this.minHoursInclusive: 0,
    this.minMinutesInclusive: 0,
    this.minSecondsInclusive: 0,
    this.minMillisecondsInclusive: 0,
    this.minMicrosecondsInclusive: 0,
    //---picker params
    this.pickerSize: 99.9,
    this.pickerItemSize: 33.3,
    this.pickerBackgroundColor: CupertinoColors.white,
    this.pickerDiameterRatio: 1.1,
    this.pickerTextStyle: const TextStyle(
      color: CupertinoColors.black,
      fontSize: 22.0,
    ),
    //---label params
    this.labelTextStyle: const TextStyle(color: CupertinoColors.black),
    this.labelBackgroundColor: CupertinoColors.white,
    //---other params
    this.topBarColor: CupertinoColors.white,
    this.titleTextStyle: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: CupertinoColors.black,
    ),
    this.titleText: "Set New Duration",
    this.buttonTextStyle: const TextStyle(
      fontSize: 18.0,
      color: Colors.blue,
    ),
    this.leftButtonText: "Cancel",
    this.rightButtonText: "Confirm",
  });

  int days; //INFINITY max
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

    return new GestureDetector(
      //-----Blocks Modal Sheet Behavior
      // (hides slow animation as a cause of the heavy flutter picker code)
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      onVerticalDragStart: (DragStartDetails d) {},
      //-----Other
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            color: topBarColor,
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: new Stack(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                      onPressed: null,
                      child: new Text(
                        titleText,
                        style: titleTextStyle,
                      ),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new FlatButton(
                      onPressed: () => onCancel(),
                      child: new Text(
                        leftButtonText,
                        style: buttonTextStyle,
                      ),
                    ),
                    new FlatButton(
                      onPressed: () => onConfirm(),
                      child: new Text(
                        rightButtonText,
                        style: buttonTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          new Row(
            children: <Widget>[
              (showDays)
                  ? durationPickerLabel(
                      durationTimeType.days.toString().split('.')[1])
                  : new Text(""),
              (showHours)
                  ? durationPickerLabel(
                      durationTimeType.hours.toString().split('.')[1])
                  : new Text(""),
              (showMinutes)
                  ? durationPickerLabel(
                      durationTimeType.minutes.toString().split('.')[1])
                  : new Text(""),
              (showSeconds)
                  ? durationPickerLabel(
                      durationTimeType.seconds.toString().split('.')[1])
                  : new Text(""),
              (showMilliseconds)
                  ? durationPickerLabel(
                      durationTimeType.milliseconds.toString().split('.')[1])
                  : new Text(""),
              (showMicroseconds)
                  ? durationPickerLabel(
                      durationTimeType.microseconds.toString().split('.')[1])
                  : new Text(""),
            ],
          ),
          new Container(
            height: pickerSize,
            child: new Row(
              children: <Widget>[
                (showDays)
                    ? durationPicker(
                        days,
                        durationTimeType.days,
                        minDaySpaces,
                        minDaysInclusive,
                        maxDaysExclusive,
                      )
                    : new Text(""),
                (showHours)
                    ? durationPicker(
                        hours,
                        durationTimeType.hours,
                        minHourSpaces,
                        minHoursInclusive,
                        maxHoursExclusive,
                      )
                    : new Text(""),
                (showMinutes)
                    ? durationPicker(
                        minutes,
                        durationTimeType.minutes,
                        minMinuteSpaces,
                        minMinutesInclusive,
                        maxMinutesExclusive,
                      )
                    : new Text(""),
                (showSeconds)
                    ? durationPicker(
                        seconds,
                        durationTimeType.seconds,
                        minSecondSpaces,
                        minSecondsInclusive,
                        maxSecondsExclusive,
                      )
                    : new Text(""),
                (showMilliseconds)
                    ? durationPicker(
                        milliseconds,
                        durationTimeType.milliseconds,
                        minMillisecondSpaces,
                        minMillisecondsInclusive,
                        maxMillisecondsExclusive,
                      )
                    : new Text(""),
                (showMicroseconds)
                    ? durationPicker(
                        microseconds,
                        durationTimeType.microseconds,
                        minMicrosecondSpaces,
                        minMicrosecondsInclusive,
                        maxMicrosecondsExclusive,
                      )
                    : new Text(""),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded durationPickerLabel(String label) {
    return new Expanded(
      child: new Container(
        color: labelBackgroundColor,
        padding: EdgeInsets.all(2.0),
        alignment: Alignment.center,
        child: new Text(
          label,
          maxLines: 1,
          style: labelTextStyle,
        ),
      ),
    );
  }

  Flexible durationPicker(
    int initItem,
    durationTimeType dType,
    int leastLength,
    int minValue,
    int maxValue,
  ) {

    int numberOfItems = 0;
    if(minValue < maxValue)
      numberOfItems = (maxValue - minValue).abs();
    else
      print("ERROR minValue >= maxValue");

    return new Flexible(
      child: new CupertinoPicker(
        diameterRatio: pickerDiameterRatio,
        backgroundColor: pickerBackgroundColor,
        scrollController:
            new FixedExtentScrollController(initialItem: initItem),
        itemExtent: pickerItemSize,
        onSelectedItemChanged: (int index) {
          switch (dType) {
            case durationTimeType.days:
              days = index;
              break;
            case durationTimeType.hours:
              hours = index;
              break;
            case durationTimeType.minutes:
              minutes = index;
              break;
            case durationTimeType.seconds:
              seconds = index;
              break;
            case durationTimeType.milliseconds:
              milliseconds = index;
              break;
            default:
              microseconds = index;
              break;
          }
        },
        children: new List<Widget>.generate(numberOfItems, (int index) {
          return new Center(
            child: new Text(
              atleastLengthOfn(minValue + index, leastLength),
              style: pickerTextStyle,
            ),
          );
        }),
      ),
    );
  }
}
