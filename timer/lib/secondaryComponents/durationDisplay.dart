import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer/secondaryComponents/duration.dart';

class DurationDisplay extends StatefulWidget {
  final Function value;
  final bool showDays;
  final bool showHours;
  final bool showMinutes;
  final bool showSeconds;
  final bool showMilliseconds;
  final bool showMicroseconds;

  DurationDisplay({
    @required this.value,
    this.showDays: true,
    this.showHours: true,
    this.showMinutes: true,
    this.showSeconds: true,
    this.showMilliseconds: true,
    this.showMicroseconds: true,
  });

  @override
  _DurationDisplayState createState() => _DurationDisplayState();
}

class _DurationDisplayState extends State<DurationDisplay> {

  final days = ValueNotifier<int>(0);
  final hours = ValueNotifier<int>(0);
  final minutes = ValueNotifier<int>(0);
  final seconds = ValueNotifier<int>(0);
  final milliseconds = ValueNotifier<int>(0);
  final microseconds = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    updateTimeShown();
    autoUpdate();
  }

  autoUpdate() async {
    var prevValue;
    while (true) {
      await Future.delayed(new Duration(microseconds: 16666));
      var currValue = widget.value();
      if (this.mounted && currValue != prevValue) {
        prevValue = currValue;
        updateTimeShown();
      }
    }
  }

  updateTimeShown(){
    List timeShown = getFormattedDuration(widget.value());
    days.value=timeShown[0];
    hours.value=timeShown[1];
    minutes.value=timeShown[2];
    seconds.value=timeShown[3];
    milliseconds.value=timeShown[4];
    microseconds.value=timeShown[5];
  }

  @override
  Widget build(BuildContext context) {

    List<bool> spots = [
      widget.showDays,
      widget.showHours,
      widget.showMinutes,
      widget.showSeconds,
      widget.showMilliseconds,
      widget.showMicroseconds,
    ];

    //brief snippet of code that determines what spaces to show inbetween
    List<int> spacesUsed = [];
    bool testBool = false;
    for (int i = 0; i < 6; i++) {
      if (spots[i] == true) {
        if (testBool == false)
          testBool = true;
        else {
          spacesUsed.add(i);
          testBool == false;
        }
      }
    }

    return new Container(
      width: MediaQuery.of(context).size.width,
      child: new ConstrainedBox(
        constraints:
        BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
        child: new FittedBox(
          fit: BoxFit.contain,
          child: new Container(
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (widget.showDays)
                    ? new AnimatedBuilder(
                  animation: days,
                  builder: (context, child){
                    return TimeUnit(
                      number: atleastLengthOfn(days.value, 2),
                      unit: "days",
                    );
                  },
                )
                    : new Text(""),
                (widget.showHours)
                    ? new AnimatedBuilder(
                  animation: hours,
                  builder: (context, child){
                    return TimeUnit(
                      number: atleastLengthOfn(hours.value, 2),
                      unit: "hours",
                    );
                  },
                )
                    : new Text(""),
                (widget.showMinutes)
                    ? new AnimatedBuilder(
                  animation: minutes,
                  builder: (context, child){
                    return TimeUnit(
                      number: atleastLengthOfn(minutes.value, 2),
                      unit: "minutes",
                    );
                  },
                )
                    : new Text(""),
                (widget.showSeconds)
                    ? new AnimatedBuilder(
                  animation: seconds,
                  builder: (context, child){
                    return TimeUnit(
                      number: atleastLengthOfn(seconds.value, 2),
                      unit: "seconds",
                    );
                  },
                )
                    : new Text(""),
                (widget.showMilliseconds)
                    ? new AnimatedBuilder(
                  animation: milliseconds,
                  builder: (context, child){
                    return TimeUnit(
                      number: atleastLengthOfn(milliseconds.value, 3),
                      unit: "milliseconds",
                    );
                  },
                )
                    : new Text(""),
                (widget.showMicroseconds)
                    ? new AnimatedBuilder(
                  animation: microseconds,
                  builder: (context, child){
                    return TimeUnit(
                      number: atleastLengthOfn(microseconds.value, 3),
                      unit: "microseconds",
                    );
                  },
                )
                    : new Text(""),
              ],
            ),
          ),
        ),
      ),
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