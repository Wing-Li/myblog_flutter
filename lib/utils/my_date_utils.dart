import 'my_utils.dart';

class MyDateUtils {
  static String getCurrentTime() {
    DateTime date = DateTime.now();
    return "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
  }

  static String getCurrentYMD() {
    DateTime date = DateTime.now();
    return "${date.year}-${date.month < 10 ? "0${date.month}" : date.month}-${date.day < 10 ? "0${date.day}" : date.day}";
  }

  static String getTime(String formattedString) {
    DateTime date = DateTime.parse(formattedString);
    return "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
  }

  static DateTime formatDateStr(String formattedString) {
    return DateTime.parse(formattedString);
  }

  static String formatMillisecondsSinceEpoch(int m) {
    if (m == null) return "";
    DateTime date = DateTime.fromMillisecondsSinceEpoch(m);
    return "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
  }

  static String getDayByMillisecondsSinceEpoch(int m) {
    if (m == null) return "";
    DateTime date = DateTime.fromMillisecondsSinceEpoch(m);
    return "${date.year}-${date.month < 10 ? "0${date.month}" : date.month}-${date.day < 10 ? "0${date.day}" : date.day}";
  }

  static String formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.year}-${date.month < 10 ? "0${date.month}" : date.month}-${date.day < 10 ? "0${date.day}" : date.day}";
  }

  static String tranImTimeByStr(String time) {
    if (MyUtils.isEmpty(time)) return "";
    var createTime = DateTime.parse(time).millisecondsSinceEpoch / 1000;
    return tranImTime(createTime);
  }

  static String tranImTime(double createTime) {
    String duration;
    int minute = 60;
    int hour = minute * 60;
    int day = hour * 24;
    int week = day * 7;
    int month = day * 30;

    var nowTime = DateTime.now().millisecondsSinceEpoch / 1000; //到秒
    var leftTime = nowTime - createTime;

    if (leftTime / month > 6) {
      duration = getDayByMillisecondsSinceEpoch(createTime.toInt());
    } else if (leftTime / month >= 1) {
      duration = (leftTime / month).floor().toString() + ' months ago';
    } else if (leftTime / week >= 1) {
      duration = (leftTime / week).floor().toString() + ' weeks ago';
    } else if (leftTime / day >= 1) {
      duration = (leftTime / day).floor().toString() + ' days ago';
    } else if (leftTime / hour >= 1) {
      duration = (leftTime / hour).floor().toString() + ' hours ago';
    } else if (leftTime / minute >= 1) {
      duration = (leftTime / minute).floor().toString() + '  minutes ago';
    } else {
      duration = 'Just now';
    }
    return duration;
  }

  static final num ONE_MINUTE = 60000;
  static final num ONE_HOUR = 3600000;
  static final num ONE_DAY = 86400000;
  static final num ONE_WEEK = 604800000;

  static num toSeconds(num date) {
    return date / 1000;
  }

  static num toMinutes(num date) {
    return toSeconds(date) / 60;
  }

  static num toHours(num date) {
    return toMinutes(date) / 60;
  }

  static num toDays(num date) {
    return toHours(date) / 24;
  }

  static num toMonths(num date) {
    return toDays(date) / 30;
  }

  static num toYears(num date) {
    return toMonths(date) / 365;
  }
}
