import 'dart:async';

import 'package:flutter/material.dart';

import 'timer.dart' as timerWidget;

//days, hours, minutes, seconds, milliseconds, microseconds

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {

  timerWidget.Timer timer = new timerWidget.Timer();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: timer,
    );
  }
}

/*
class TimerUI extends StatefulWidget {

  String atleastLengthOfn(int num, int minLength){
    String numStr = num.toString();
    int added0s = minLength - numStr.length;
    for(int i=added0s; i>0; i--)
      numStr = "0" + numStr;
    return numStr;
  }

  @override
  _TimerUIState createState() {
    return new _TimerUIState();
  }
}

class _TimerUIState extends State<TimerUI> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

      //if(widget.timer.functions.isRunning())
        setState(() {}); //update our UI based on our timer
    }
  }

  void showInSnackBar(String message, String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
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

  @override
  Widget build(BuildContext context) {

    List timeLeft = timer.getFormattedDuration(timer.getTimeLeft());

    return new MaterialApp(
      theme: ThemeData.dark(),
      home: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text("Timer"),
        ),
        body: new Container(
            color: Theme.of(context).primaryColorDark,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new FlatButton(
                    onPressed: (){

                    },
                    child: new Text("Reset"),
                  ),
                ),
                new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new TimeUnit(
                          number: widget.atleastLengthOfn(timeLeft[0],2),
                          unit: "Days",
                        ),
                        new TimeSpacing(),
                        new TimeUnit(
                          number: widget.atleastLengthOfn(timeLeft[1],2),
                          unit: "Hours",
                        ),
                        new TimeSpacing(),
                        new TimeUnit(
                          number: widget.atleastLengthOfn(timeLeft[2],2),
                          unit: "Minutes",
                        ),
                        new TimeSpacing(),
                        new TimeUnit(
                          number: widget.atleastLengthOfn(timeLeft[3],2),
                          unit: "Seconds",
                        ),
                        new TimeSpacing(),
                        new TimeUnit(
                          number: widget.atleastLengthOfn(timeLeft[4],3),
                          unit: "Milliseconds",
                        ),
                        new TimeSpacing(),
                        new TimeUnit(
                          number: widget.atleastLengthOfn(timeLeft[5],3),
                          unit: "Microseconds",
                        ),
                      ],
                    )
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new FlatButton(
                    onPressed: () => timer.start(),
                    child: new Text("start"),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new FlatButton(
                    onPressed: () => timer.stop(),
                    child: new Text("stop"),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new FlatButton(
                          onPressed: () => showInSnackBar("Original Time", ""),
                          child: new Text("Original Time")
                      ),
                      new Text("="),
                      new FlatButton(
                          onPressed: () => showInSnackBar("Time Left", ""),
                          child: new Text("Time Left")
                      ),
                      new Text("+"),
                      new FlatButton(
                          onPressed: () => showInSnackBar("Time Pased", ""),
                          child: new Text("Time Passed")
                      ),
                    ],
                  ),
                ),
              ],
            )
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
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
                text: number,
              ),
              new TextSpan(
                  text: "\n$unit"
              ),
            ]
        ),
      ),
    );
  }
}
*/

/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(
  new Material(
    child: new MaterialApp(
      home: new TextFormFieldDemo(),
    ),
  ),
);

class TextFormFieldDemo extends StatefulWidget {
  @override
  TextFormFieldDemoState createState() => new TextFormFieldDemoState();
}

class TextFormFieldDemoState extends State<TextFormFieldDemo>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String number = "";

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  bool _autovalidate = false;
  bool _formWasEdited = false;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _UsNumberTextInputFormatter _numberFormatter = new _UsNumberTextInputFormatter();
  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      showInSnackBar('${number}\ is the number');
    }
  }

  String _validateNumber(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Number is required.';
    final RegExp phoneExp = new RegExp(r'\d+');
    if (!phoneExp.hasMatch(value))
      return 'Enter a Number in this format';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: _autovalidate,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    icon: const Icon(Icons.phone),
                    hintText: 'Where can we reach you?',
                    labelText: 'Phone Number *',
                    prefixText: '+1',
                  ),
                  keyboardType: TextInputType.phone, //TextInputType.number
                  onSaved: (String value) { number = value; },
                  validator: _validateNumber,
                  // TextInputFormatters are applied in sequence.
                  inputFormatters: <TextInputFormatter> [
                    WhitelistingTextInputFormatter.digitsOnly,
                    // Fit the validating format.
                    //_numberFormatter,
                  ],
                ),
                const SizedBox(height: 24.0),
                new Center(
                  child: new RaisedButton(
                    child: const Text('SUBMIT'),
                    onPressed: _handleSubmitted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Format incoming numeric text to fit the format of (###) ###-#### ##...
class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
      ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1)
        selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3)
        selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6)
        selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10)
        selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class PersonData {
  String phoneNumber = '';
}
*/