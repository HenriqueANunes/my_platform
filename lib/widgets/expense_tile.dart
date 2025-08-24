import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_platform/models/expense_model.dart';

final _dateFormatter = DateFormat('dd/MM/yyyy');

Widget expenseTile(ExpenseModel expense, ThemeData theme) {
  final startDate = expense.date_start != null
      ? _dateFormatter.format(expense.date_start!)
      : '';
  final endDate = expense.date_end != null
      ? _dateFormatter.format(expense.date_end!)
      : '';

  String dateText = '';
  if (startDate.isNotEmpty && endDate.isNotEmpty) {
    dateText = '$startDate - $endDate';
  } else if (startDate.isNotEmpty) {
    dateText = startDate;
  } else if (endDate.isNotEmpty) {
    dateText = endDate;
  }

  return ListTile(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    tileColor: theme.cardColor,
    leading: const Icon(Icons.trending_down),
    title: Text(expense.name),
    subtitle: Text(dateText.isNotEmpty ? dateText : ''),
    trailing: Text(expense.value.toStringAsFixed(2)), // força 2 casas decimais
  );
}
