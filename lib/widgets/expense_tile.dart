import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_platform/models/expense_model.dart';


Widget expenseTile(ExpenseModel expense, theme) => ListTile(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  tileColor: theme.cardColor,
  leading: Icon(Icons.trending_down),
  title: Text(expense.name),
  subtitle: Text('${expense.date_start.toString()} - ${expense.date_end}'),
  trailing: Text(expense.value.toString()),
);
