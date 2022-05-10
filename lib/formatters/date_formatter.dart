import 'package:intl/intl.dart';

final _timeFormat = DateFormat("HH:mm");
final _dateFormat = DateFormat("dd.MM.yyyy");

String historyFormattedDate(int date) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);
  DateTime now = DateTime.now();
  final diff = now.difference(dateTime);
  switch (diff.inDays) {
    case 0:
      return _timeFormat.format(dateTime);
    case 1:
      return "Вчера, ${_timeFormat.format(dateTime)}";
    default:
      return _dateFormat.format(dateTime);
  }
}
