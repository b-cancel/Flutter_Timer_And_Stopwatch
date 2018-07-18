import 'package:flutter/material.dart';

import 'duration.dart';

import 'package:flutter/cupertino.dart';

class DurationPicker extends StatelessWidget {

  double _kPickerSheetHeight = 216.0;
  double _kPickerItemHeight = 32.0;

  int days;
  int hours;
  int minutes;
  int seconds;
  int milliseconds;
  int microseconds;

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
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "Set New Duration",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
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
                          scrollController: new FixedExtentScrollController(initialItem: 365),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => days = index,
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
                          scrollController: new FixedExtentScrollController(initialItem: 24),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => hours = index,
                          children: new List<Widget>.generate(25, (int index) {
                            return new Center(child:
                            new Text((index).toString()),
                            );
                          }),
                        ),
                      ),
                      new Flexible(
                        fit: FlexFit.tight,
                        child: new CupertinoPicker(
                          scrollController: new FixedExtentScrollController(initialItem: 60),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => minutes = index,
                          children: new List<Widget>.generate(61, (int index) {
                            return new Center(child:
                            new Text((index).toString()),
                            );
                          }),
                        ),
                      ),
                      new Flexible(
                        fit: FlexFit.tight,
                        child: new CupertinoPicker(
                          scrollController: new FixedExtentScrollController(initialItem: 60),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => seconds = index,
                          children: new List<Widget>.generate(61, (int index) {
                            return new Center(child:
                            new Text((index).toString()),
                            );
                          }),
                        ),
                      ),
                      new Flexible(
                        fit: FlexFit.tight,
                        child: new CupertinoPicker(
                          scrollController: new FixedExtentScrollController(initialItem: 1000),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => milliseconds = index,
                          children: new List<Widget>.generate(1001, (int index) {
                            return new Center(child:
                            new Text((index).toString()),
                            );
                          }),
                        ),
                      ),
                      new Flexible(
                        fit: FlexFit.tight,
                        child: new CupertinoPicker(
                          scrollController: new FixedExtentScrollController(initialItem: 1000),
                          itemExtent: _kPickerItemHeight,
                          backgroundColor: CupertinoColors.white,
                          onSelectedItemChanged: (int index) => microseconds = index,
                          children: new List<Widget>.generate(1001, (int index) {
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