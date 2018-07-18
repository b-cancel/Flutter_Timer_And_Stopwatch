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
}

class Timer extends StatefulWidget {

  final TimerFunctions functions = new TimerFunctions();

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with SingleTickerProviderStateMixin{

  AnimationController timer;
  //REQUIRED because our "timer.duration" will not always be what we set it to originally because technically pausing (or stopping) a timer stops it and sets it all over again
  Duration originalTime; //ONLY SET in the set method [no exceptions]
  //REQUIRED because our timer is paused (or stopped) it you can no longer access "timer.lastElapsedDuration"
  Duration lastElapsedDurationNOANIM; //ONLY NOT NULL when our timer is not animating

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
  }

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

  @override
  Widget build(BuildContext context) {
    linkFunctions();

    return new Container(
      child: new Text(""),
    );
  }

  @override
  void dispose(){
    timer.dispose();
    super.dispose();
  }
  
  /*
  There are 2 main states the timer can be in... And multiple sub states... And each has its own signature
  - - - 0. Both
  * original Time, time Left (will be correct as long time passed is right)
  - - - 1. Running (timer.isAnimating, timeLeft = null)
  * !timer.isCompleted, timePassed = timer.lastElapsedDuration + (originalTime-timer.duration) [RUNNING]
  - - - 2. Not running (!timer.isAnimating, timeLeft != null)
  * timer.isCompleted, lastElapsedDurationNOANIM = null, timePassed = originalTime [DONE]
  * !timer.isCompleted, lastElapsedDurationNOANIM = null, timePassed = 0 [NEVER STARTED]
  * !timer.isCompleted, lastElapsedDurationNOANIM != null, timePassed = originalTime - lastElapsedDurationNOANIM [PAUSED]
  */

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
}
