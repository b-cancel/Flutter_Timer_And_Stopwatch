import 'dart:async';

import 'package:flutter/material.dart';

class TimerFunctions{
  //---Command Functions
  Function start;
  Function stop;
  Function set;
  Function reset;
  //---Information Functions
  Function getOriginalTime;
  Function getTimePassed;
  Function getTimeLeft;
  Function isRunning;
  //---Duration Functions
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

    linkFunctions();
  }

  linkFunctions(){
    var w = widget.functions;
    //---Command Functions
    w.start = start;
    w.stop = stop;
    w.set = set;
    w.reset = reset;
    //---Information Functions
    w.getOriginalTime = getOriginalTime;
    w.getTimePassed = getTimePassed;
    w.getTimeLeft = getTimeLeft;
    w.isRunning = isRunning;
    //---Duration Functions
    w.getFormattedDuration = getFormattedDuration;
    w.getStringFromFormattedDuration = getStringFromFormattedDuration;
    w.getStringFromDuration = getStringFromDuration;
  }

  @override
  Widget build(BuildContext context) {
    linkFunctions();

    return new Container(
      child: new Text(""),
    );
  }

  //-------------------------COMMAND FUNCTIONS-------------------------

  //we can either start a brand new timer, or start a timer from its previous location
  start(){
    if(timer.isAnimating == false){
      timer.reset(); //reset the timer to prevent odd behavior
      if(lastElapsedDurationNOANIM == null) timer.duration = originalTime; //this is the first time the timer has been started
      else timer.duration = lastElapsedDurationNOANIM; //the timer is being unpaused
      lastElapsedDurationNOANIM = null;
      timer.forward();
    }
  }

  stop(){
    if(timer.isAnimating == true){
      lastElapsedDurationNOANIM = getTimeLeft();
      timer.stop();
    }
  }

  set(Duration newDuration){

    bool wasRunning = timer.isAnimating; //save whether or not the timer was running
    stop(); //if the timer is running stop it
    timer.reset(); //reset the timer to prevent odd behavior

    //set the new timer values
    originalTime = newDuration;
    lastElapsedDurationNOANIM = null;

    //start the timer if it was running at first
    if(wasRunning) start();
  }

  reset() => set(originalTime);

  //-------------------------INFORMATION FUNCTIONS-------------------------

  Duration getOriginalTime() => originalTime;

  Duration getTimePassed(){
    if(timer.isAnimating) //the timer is playing
      return timer.lastElapsedDuration + (originalTime-timer.duration);
    else{
      if(lastElapsedDurationNOANIM != null) //the timer is paused
        return originalTime - lastElapsedDurationNOANIM;
      else{ //the timer is stopped
        if(timer.isCompleted)
          return originalTime; //the timer finished on its own (Show all 0s on screen)
        else
          return Duration.zero; //the timer never began (show original time on screen)
      }
    }
  }

  Duration getTimeLeft() => getOriginalTime() - getTimePassed();

  isRunning() => timer.isAnimating;

  //-------------------------DURATION FUNCTIONS-------------------------

  List getFormattedDuration(Duration time){
    int days, hours, minutes, seconds, milliseconds, microseconds;

    //Returns a string with hours, minutes, seconds, and microseconds, in the following format: HH:MM:SS.mmmmmm
    //0:00:00.000000
    String timeString = time.toString();
    int len = timeString.length;

    //extract all the default value
    microseconds = int.parse(timeString.substring(len-6, len));
    seconds = int.parse(timeString.substring(len-9,len-7));
    minutes = int.parse(timeString.substring(len-12,len-10));
    hours = int.parse(timeString.substring(0,len-13));

    //correct for hours and microseconds
    milliseconds = (microseconds/1000).truncate();
    microseconds = microseconds%1000;
    days = (hours/24).truncate();
    hours = hours%24;

    return [days, hours, minutes, seconds, milliseconds, microseconds];
  }

  String getStringFromFormattedDuration(List formattedDuration){
    return "\n"
        + formattedDuration[0].toString() + " days\n"
        + formattedDuration[1].toString() + " hours\n"
        + formattedDuration[2].toString() + " minutes\n"
        + formattedDuration[3].toString() + " seconds\n"
        + formattedDuration[4].toString() + " milliseconds\n"
        + formattedDuration[5].toString() + " microseconds\n";
  }

  String getStringFromDuration(Duration time) => getStringFromFormattedDuration(getFormattedDuration(time));
}