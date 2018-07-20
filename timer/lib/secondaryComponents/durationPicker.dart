import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'duration.dart';

import 'dart:math';

class DurationPicker extends StatelessWidget {

  final Duration initialDuration;
  final Function onConfirm;

  DurationPicker({
    @required this.initialDuration,
    @required this.onConfirm,
  });

  final double _kPickerSheetHeight = 216.0;
  final double _kPickerItemHeight = 32.0;

  //TODO... eliminate the use of these non final variables by using stateful pickers that allow me to retreive the last selected value (or the initial value if the value didn't change)
  int days; //365 max
  int hours; //23 max
  int minutes; //59 max
  int seconds; //59 max
  int milliseconds; //999 max
  int microseconds; //999 max

  getDuration(){
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

    CupertinoPicker pickerDays = new CupertinoPicker(
      scrollController: new FixedExtentScrollController(initialItem: days),
      itemExtent: _kPickerItemHeight,
      backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (int index) => days = index,
      children: new List<Widget>.generate(100, (int index) {
        return new Center(child:
        new Text(atleastLengthOfn(index, 2)),
        );
      }),
    );

    CupertinoPicker pickerHours = new CupertinoPicker(
      scrollController: new FixedExtentScrollController(initialItem: hours),
      itemExtent: _kPickerItemHeight,
      backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (int index) => hours = index,
      children: new List<Widget>.generate(24, (int index) {
        return new Center(child:
        new Text(atleastLengthOfn(index, 2)),
        );
      }),
    );

    CupertinoPicker pickerMinutes = new CupertinoPicker(
      scrollController: new FixedExtentScrollController(initialItem: minutes),
      itemExtent: _kPickerItemHeight,
      backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (int index) => minutes = index,
      children: new List<Widget>.generate(60, (int index) {
        return new Center(child:
        new Text(atleastLengthOfn(index, 2)),
        );
      }),
    );

    CupertinoPicker pickerSeconds = new CupertinoPicker(
      scrollController: new FixedExtentScrollController(initialItem: seconds),
      itemExtent: _kPickerItemHeight,
      backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (int index) => seconds = index,
      children: new List<Widget>.generate(60, (int index) {
        return new Center(child:
        new Text(atleastLengthOfn(index, 2)),
        );
      }),
    );

    CupertinoPicker pickerMilliseconds = new CupertinoPicker(
      scrollController: new FixedExtentScrollController(initialItem: milliseconds),
      itemExtent: _kPickerItemHeight,
      backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (int index) => milliseconds = index,
      children: new List<Widget>.generate(1000, (int index) {
        return new Center(child:
        new Text(atleastLengthOfn(index, 3)),
        );
      }),
    );

    CupertinoPicker pickerMicroseconds = new CupertinoPicker(
      scrollController: new FixedExtentScrollController(initialItem: microseconds),
      itemExtent: _kPickerItemHeight,
      backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (int index) => microseconds = index,
      children: new List<Widget>.generate(1000, (int index) {
        return new Center(child:
        new Text(atleastLengthOfn(index, 3)),
        );
      }),
    );

    return new DefaultTextStyle(
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
            color: CupertinoColors.white,
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
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
            height: _kPickerSheetHeight,
            child: new DefaultTextStyle(
              style: const TextStyle(
                color: CupertinoColors.black,
                fontSize: 22.0,
              ),
              child: new GestureDetector(
                // Blocks taps from propagating to the modal sheet and popping.
                onTap: () {},
                child: new Row(
                  children: <Widget>[
                    new Flexible(
                      fit: FlexFit.tight,
                      child: pickerDays,
                    ),
                    new Flexible(
                      fit: FlexFit.tight,
                      child: pickerHours,
                    ),
                    new Flexible(
                      fit: FlexFit.tight,
                      child: pickerMinutes,
                    ),
                    new Flexible(
                        fit: FlexFit.tight,
                        child: pickerSeconds
                    ),
                    new Flexible(
                      fit: FlexFit.tight,
                      child: pickerMilliseconds,
                    ),
                    new Flexible(
                        fit: FlexFit.tight,
                        child: pickerMicroseconds
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
class Picker extends StatelessWidget {

  final itemHeight;
  final initialItem;

  Picker({

  });

  final tino = new CupertinoPicker(
    scrollController: new FixedExtentScrollController(initialItem: days),
    itemExtent: _kPickerItemHeight,
    backgroundColor: CupertinoColors.white,
    onSelectedItemChanged: (int index) => days = index,
    children: new List<Widget>.generate(366, (int index) {
      return new Center(child:
      new Text(atleastLengthOfn(index, 3)),
      );
    }),
  );

  @override
  Widget build(BuildContext context) {
    return tino;
  }
}
*/
