import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class hi extends StatefulWidget {
  @override
  _hiState createState() => _hiState();
}

class _hiState extends State<hi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: Row(
        children: <Widget>[
          new RaisedButton(
              child: const Text('ALERT WITH TITLE'),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => new AlertDialog(
                      title: const Text('Use Google\'s location service?'),
                      content: new Row(
                        children: <Widget>[
                          new CupertinoPicker(
                              itemExtent: 26.0,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  print("selected was " + index.toString());
                                });
                              },
                              children: null,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        new FlatButton(
                            child: const Text('DISAGREE'),
                            onPressed: () { Navigator.pop(context, "DISAGREE"); }
                        ),
                        new FlatButton(
                            child: const Text('AGREE'),
                            onPressed: () { Navigator.pop(context); }
                        )
                      ]
                  ),
                )
                .then<void>((String value) { // The value passed to Navigator.pop() or null.
                  if (value != null) {
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                        content: new Text('You selected: $value')
                    ));
                  }
                });
              }
          ),
        ],
      ),
    );
  }
}