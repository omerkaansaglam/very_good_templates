import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime? {
  String get formattedDate {
    return this != null ? DateFormat('dd.MM.yyyy').format(this!) : '';
  }

  String get formattedDateWithTime {
    return this != null ? DateFormat('dd/MM/yyyy - HH:mm').format(this!) : '';
  }

  String get formattedDateFirstYear {
    return this != null ? DateFormat('yyyy.MM.dd').format(this!) : '';
  }

  int? get currentAge {
    if (this == null) null;
    final now = DateTime.now();
    final age = now.year - this!.year;
    final month = now.month - this!.month;
    final day = now.day - this!.day;
    if (month < 0 || (month == 0 && day < 0)) {
      return age - 1;
    }
    return age;
  }

  int differenceInDaysFromNow() {
    DateTime now = DateTime.now();

    DateTime dateOnly = DateTime(this!.year, this!.month, this!.day);
    DateTime nowOnly = DateTime(now.year, now.month, now.day);

    return dateOnly.difference(nowOnly).inDays;
  }

  String get formattedDateWithHoursMinutesSeconds {
    return this != null ? DateFormat('dd_MM_yyyy_HH_mm_ss').format(this!) : '';
  }
}

extension SafeDateTimeExtension on DateTime {
  String getTimestamp() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }
}
