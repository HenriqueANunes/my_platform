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
  final _expenseObj = ExpenseService();
  late Future<List<ExpenseModel?>> _expensesList;

  @override
  void initState() {
    super.initState();
    _expensesList = _expenseObj.getAllExpenses(); // Initialize your future in initState
  }

  void _refreshData() {
    setState(() {
      _expensesList = _expenseObj.getAllExpenses(); // Assign a new Future to trigger rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas cadastradas'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        iconTheme: theme.appBarTheme.iconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
      ),
      body: FutureBuilder<List<ExpenseModel?>>(
          future: _expensesList,
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
        onPressed: () async {
          await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => ExpenseForm(),
          );
          _refreshData();
        },
        tooltip: 'Cadatrar Despesa',
        backgroundColor: theme.floatingActionButtonTheme.backgroundColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}