class Expense {
  final int? id;
  final String name;
  final double value;
  final DateTime? date_start;
  final DateTime? date_end;
  final String type;

  Expense({this.id, required this.name, required this.value, this.date_start, this.date_end, required this.type});

  // 'Object' to 'Map'
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }

    map['name'] = name;
    map['value'] = value;
    map['date_start'] = date_start.toString();
    map['date_end'] = date_end.toString();

    map['type'] = type;

    return map;
  }

  // 'Map' to 'Object'
  factory Expense.fromString(Map<String, dynamic> data) => Expense(
    id: data['id'],
    name: data['name'],
    value: data['value'],
    date_start: DateTime.parse(data['date_start']),
    date_end: DateTime.parse(data['date_end']),
    type: data['type'],
  );
}
