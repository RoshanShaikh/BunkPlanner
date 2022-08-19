abstract class Weekday {
  static const monday = 'Monday';
  static const tuesday = 'Tuesday';
  static const wednesday = 'Wednesday';
  static const thursday = 'Thursday';
  static const friday = 'Friday';
  static const saturday = 'Saturday';
  static const sunday = 'Sunday';

  static final List<String> _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static String getString(int index) {
    if (index < 1 || index > 7) throw RangeError.range(index, 1, 7);
    return _weekdays[index - 1];
  }

  static int getIndex(String day) {
    int index = _weekdays.indexOf(day);
    if (index == -1) throw ArgumentError.value(day, 'Should be valid WeekDay.');
    return index + 1;
  }

  static fromDateTime(DateTime date) {
    return _weekdays[date.weekday - 1];
  }
}
