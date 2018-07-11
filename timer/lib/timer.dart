import 'dart:async';

import 'package:flutter/material.dart';

///Description: Timer Widget that works by counting down one single timeValue
///Example: suppose my Time Unit is seconds, then I can count down from 90
///I can then interpret that 90 as 1 minute and 30 seconds

enum TimeUnit {days, hours, minutes, seconds, milliseconds, microseconds}
//1000 microseconds [3] = 1 millisecond
//1000 milliseconds [3] = 1 second
//60 seconds [2] = 1 minute
//60 minutes [2] = 1 hour
//24 hours [2] = 1 day

class TimerFunctions{
  //---Single Timer Functions
  Function setTimer;
  Function startTimer;
  Function stopTimer;
  Function resetAndStopTimer;
  //---Double [OR] Timer Functions
  Function startOrStopTimer;
  //---Double [AND] Timer Functions
  Function setAndStartTimer;
  Function setAndStopTimer;
  Function stopAndSetTimer;
  Function resetAndStopAndStart;
  //---Getter Functions
  Function getTotalTime;
  Function getTimePassed;
  Function getTimeLeft;
  Function isRunning;
  //---Other Functions
  Function setTimeUnit;
  Function setTimeUnitMax;
  Function getTimeUnit;
  Function getTimeUnitMax;
  //---Functions that should already exists in the duration class
  Function getFormattedDuration;
  Function getStringFromFormattedDuration;
  Function getStringFromDuration;
}

class Timer extends StatefulWidget {

  final TimerFunctions functions = new TimerFunctions();

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with SingleTickerProviderStateMixin{

  AnimationController timer;
  //REQUIRED because our "timer.duration" will not always be what we set it to originally because technically pausing (or stopped) a timer stops it and sets it all over again
  Duration originalTime; //ONLY SET in the set method [no exceptions]
  //REQUIRED because our timer is paused (or stopped) it you can no longer access "timer.lastElapsedDuration"
  Duration lastElapsedDurationNOANIM; //ONLY NOT NULL when our timer is not animating

  @override
  void initState() {
    super.initState();
    timer = new AnimationController(
      vsync: this,
    );
    originalTime = Duration.zero;
    lastElapsedDurationNOANIM = null;

    autoUpdateUI();
  }

  autoUpdateUI() async{
    int updatesPerSecond = 60; //60 is the max that will make any visual difference
    while(true){
      int millisecondsToWait = ((1/updatesPerSecond) * 1000).round();
      await Future.delayed(new Duration(milliseconds: millisecondsToWait)); //wait some time before updating our UI
      setState(() {}); //update our UI based on our timer
    }
  }

  @override
  Widget build(BuildContext context) {
    String theString = getTimeLeft().toString();

    return new Scaffold(
      body: new Container(
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(theString),
            new FlatButton(
              onPressed: () => set(new Duration(seconds: 10)),
              child: new Text("Set to 10 seconds"),
            ),
            new FlatButton(
              onPressed: () => set(new Duration(seconds: 20)),
              child: new Text("Set to 20 seconds"),
            ),
            new FlatButton(
              onPressed: () => set(new Duration(seconds: 30)),
              child: new Text("Set to 30 seconds"),
            ),
            new FlatButton(
              onPressed: () => start(),
              child: new Text("start"),
            ),
            new FlatButton(
              onPressed: () => stop(),
              child: new Text("stop"),
            ),
            new FlatButton(
              onPressed: () => reset(),
              child: new Text("reset"),
            ),
          ],
        )
      ),
    );
  }
  
  /*
  There are 2 main states the timer can be in... And multiple sub states... And each has its signature
  - - - 0. Either
  * total Time, time Left (will be correct as long time passed is right) 
  - - - 1. Running (timer.isAnimating, timeLeft = null)
  * !timer.isCompleted, timePassed = timer.elapsed RUNNING
  - - - 2. Not running (!timer.isAnimating, timeLeft != null)
  * timer.isCompleted... DONE
  * !TIMER.ISCOMPLETED... NEVER STARTED
  *.!timer.isCompleted... PAUSED
  */

  //-------------------------SINGLE TIMER METHODS-------------------------

  set(Duration newDuration){
    //save whether or not the timer was running
    bool wasRunning = isRunning();

    //if the timer is running stop it
    stop();

    //set the new timer values
    originalTime = newDuration;
    lastElapsedDurationNOANIM = null;

    //start the timer if it was running at first
    if(wasRunning) start();
  }

  //we can either start a brand new timer, or start a timer from its previous location
  start(){
    if(isRunning() == false){
      timer.reset(); //without this the timer will behave oddly (often going faster than it should)
      if(lastElapsedDurationNOANIM == null) timer.duration = originalTime;
      else timer.duration = lastElapsedDurationNOANIM;
      print("START");
      print("timer will run for " + timer.duration.toString());
      lastElapsedDurationNOANIM = null;
      timer.forward();
    }
  }

  stop(){
    if(isRunning() == true){
      print("needed to stop");
      lastElapsedDurationNOANIM = getTimeLeft(); //how much time is left (this is accurate)
      print("END");
      timer.stop();
    }
  }

  reset(){

  }

  Duration getOriginalTime() => originalTime;
  Duration getTimePassed(){
    if(timer.isAnimating)
      return timer.lastElapsedDuration + (originalTime-timer.duration);
    else{ //timer.lastElapsedDuration == null
      if(lastElapsedDurationNOANIM != null) //we have paused the timer
        return getOriginalTime() - lastElapsedDurationNOANIM;
      else{
        if(timer.isCompleted)
          return getOriginalTime(); //we should see all 0s
        else //time has never been started
          return Duration.zero; //we should see the original time
      }
    }
  }
  Duration getTimeLeft() => getOriginalTime() - getTimePassed();

  isRunning() => timer.isAnimating;
}
