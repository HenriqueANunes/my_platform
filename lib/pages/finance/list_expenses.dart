import 'package:flutter/material.dart';
import 'package:my_platform/models/database_model.dart';
import 'package:my_platform/widgets/expense_form.dart';

class ListExpensesPage extends StatefulWidget {
  const ListExpensesPage({super.key});

  @override
  State<StatefulWidget> createState() => ExpensesList();

}

class ExpensesList extends State<ListExpensesPage> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final DatabaseService _databaseService = DatabaseService.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas cadastradas'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        iconTheme: theme.appBarTheme.iconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
      ),
      body: getExpenses(),
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

  ListView getExpenses() {
    final theme = Theme.of(context);
    int qtdExpenses = 1;

    return ListView.builder(
      itemCount: qtdExpenses,
      itemBuilder: (context, index) {
        return Card(
            color: theme.cardColor,
            // elevation: 2.0,
            child: ListTile(
              leading: Icon(Icons.trending_down),
              title: Text('teste'),
              trailing: Text('R\$ 1.000,00'),
            )
        );
      },
    );
  }
}