import 'dart:math';

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

Duration getRandomDuration({
  bool randomDays = false,
  bool randomHours = false,
  bool randomMinutes = false,
  bool randomSeconds = false,
  bool randomMilliseconds = false,
  bool randomMicroseconds = false
}){
  var rand = new Random();
  return new Duration(
    days: (randomDays) ? rand.nextInt(365) : 0,
    hours: (randomHours) ? rand.nextInt(24) : 0,
    minutes: (randomMinutes) ? rand.nextInt(60) : 0,
    seconds: (randomSeconds) ? rand.nextInt(60) : 0,
    milliseconds: (randomMilliseconds) ? rand.nextInt(1000) : 0,
    microseconds: (randomMicroseconds) ? rand.nextInt(1000) : 0,
  );
}

String atleastLengthOfn(int num, int minLength) {
  String numStr = num.toString();
  int added0s = minLength - numStr.length;
  if(num < 0) numStr = numStr.substring(1); //remove the negative sign
  for (int i = added0s; i > 0; i--) numStr = "0" + numStr;
  if(num >= 0) return numStr;
  else return ("-" + numStr);
}