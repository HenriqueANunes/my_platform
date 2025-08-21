import 'package:flutter/material.dart';
import 'package:my_platform/widgets/expense_form.dart';
import 'package:my_platform/widgets/expense_tile.dart';
import 'package:my_platform/services/expense_service.dart';
import 'package:my_platform/models/expense_model.dart';

class ListExpensesPage extends StatefulWidget {
  const ListExpensesPage({super.key});

  @override
  State<StatefulWidget> createState() => ExpensesList();

}

class ExpensesList extends State<ListExpensesPage> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Future<List<ExpenseModel?>> expensesList = ExpenseService().getAllExpenses();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas cadastradas'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        iconTheme: theme.appBarTheme.iconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
      ),
      body: FutureBuilder<List<ExpenseModel?>>(
          future: expensesList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            } else if ( snapshot.connectionState == ConnectionState.done){
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Center(child: Text('$error'));
              } else {
                final expensesList = snapshot.data;
                return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: expensesList == null ? 0 : expensesList.length,
                    itemBuilder: (context, index) {
                      final expense = expensesList![index];
                      return expenseTile(expense!, theme);
                    },
                );
              }
            } else {
              return const Center(child: Text('teste'));
            }
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => ExpenseForm(),
          );
        },
        tooltip: 'Cadatrar Despesa',
        backgroundColor: theme.floatingActionButtonTheme.backgroundColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}