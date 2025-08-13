import 'package:flutter/material.dart';

class RegisterExpensesPage extends StatelessWidget {
  const RegisterExpensesPage({super.key});

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
      body: Center(
        child: Text('teste'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('teste'),
        tooltip: 'Cadatrar Despesa',
        child: const Icon(Icons.add),
        backgroundColor: theme.floatingActionButtonTheme.backgroundColor,
      ),
    );
  }



}
