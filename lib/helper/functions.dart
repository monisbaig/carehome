
String fixDay(int day){
  if(day < 10){
    return "0"+day.toString();
  }

  return day.toString();
}
String fixMonth(int month){
  if(month < 10){
    return "0"+month.toString();
  }

  return month.toString();
}