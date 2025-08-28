import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_platform/models/expense_model.dart';
import 'package:my_platform/widgets/expense_form.dart';

final _dateFormatter = DateFormat('dd/MM/yyyy');

Widget expenseTile(BuildContext context, ExpenseModel expense, ThemeData theme, VoidCallback onRefresh) {
  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );
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
    subtitle: Text(dateText.isNotEmpty ? dateText : 'Sem data'),
    trailing: Text(
      _formatter.format(expense.value),
      style: TextStyle(fontSize: 20),
    ),
    onTap: () async {
      final status = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => ExpenseForm(expense: expense),
      );
      if (status == true) {
        onRefresh();
      }
    },
  );
}
