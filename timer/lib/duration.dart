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