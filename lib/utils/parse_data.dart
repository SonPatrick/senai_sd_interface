class Formatter {
  String parseDate({required String date}) {
    DateTime datetime = DateTime.parse(date);
    String formattedDate =
        "${datetime.day.toString().padLeft(2, '0')}/${datetime.month.toString().padLeft(2, '0')}/${datetime.year.toString()}";
    return formattedDate;
  }
}
