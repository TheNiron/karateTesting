function fn(s) {
  var SimpleDateFormat = Java.type("java.text.SimpleDateFormat");
  var format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
  try {
    format.parse(s).time;
    return true;
  } catch(e) {
    karate.log('*** invalid date string:', s);
    return false;
  }
}