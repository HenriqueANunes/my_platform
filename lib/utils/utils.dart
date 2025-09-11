int getYearMonth(){
  DateTime now = DateTime.now();

  String currentYearmonth = '${now.year}${now.month.toString().padLeft(2, '0')}';

  return int.parse(currentYearmonth);

}