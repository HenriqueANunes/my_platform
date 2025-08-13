import 'package:flutter/material.dart';

class MonthlyCalculationPage extends StatelessWidget {
  const MonthlyCalculationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculo Mensal'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        iconTheme: theme.appBarTheme.iconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
      ),
      body: Center(
        child: Text('teste'),
      ),
    );
  }
}
