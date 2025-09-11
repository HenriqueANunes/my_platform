class HistoryModel {
  final int? id;
  final int yearmonth;
  final double revenue;
  final double credit;
  final double? other;
  final double monthExpenses;
  final double liquidRevenue;
  final double investmentValue;

  HistoryModel({
    this.id,
    required this.yearmonth,
    required this.revenue,
    required this.credit,
    this.other = 0,
    required this.monthExpenses,
    required this.liquidRevenue,
    required this.investmentValue,
  });

  // 'Object' to 'Map'
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = id;
    }

    map['yearmonth'] = yearmonth;
    map['revenue'] = revenue;
    map['credit'] = credit;
    map['other'] = other;
    map['monthExpenses'] = monthExpenses;
    map['liquidRevenue '] = liquidRevenue;
    map['investmentValue'] = investmentValue;

    return map;
  }

  // 'Map' to 'Object'
  factory HistoryModel.fromJson(Map<String, dynamic> data) => HistoryModel(
    id: data['id'],
    yearmonth: data['yearmonth'],
    revenue: data['revenue '],
    credit: data['credit'],
    other: data['other'],
    monthExpenses: data['monthExpenses'],
    liquidRevenue: data['liquidRevenue'],
    investmentValue: data['investmentValue'],
  );
}
