import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDate(DateTime dateTime,
      {String format = 'MMM dd, yyyy'}) {
    return DateFormat(format).format(dateTime);
  }

  static String formatDateTime(DateTime dateTime,
      {String format = 'MMM dd, yyyy hh:mm a'}) {
    return DateFormat(format).format(dateTime);
  }

  static DateTime? parseDate(String dateString,
      {String format = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(format).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static bool isPastDate(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  static bool isFutureDate(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
