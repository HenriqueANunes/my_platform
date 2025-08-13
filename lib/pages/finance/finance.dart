import 'package:flutter/material.dart';
import 'package:my_platform/widgets/animated_square.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finanças'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        iconTheme: theme.appBarTheme.iconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define quantas colunas cabem na largura atual:
          double width = constraints.maxWidth;

          int crossAxisCount = 2; // padrão
          if (width > 1200) {
            crossAxisCount = 5;
          } else if (width > 900) {
            crossAxisCount = 4;
          } else if (width > 600) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 2;
          }

          return GridView.count(
            crossAxisCount: crossAxisCount,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              AnimatedSquare(
                icon: Icons.attach_money,
                label: 'Calculo mensal',
                onTap: () => Navigator.pushNamed(context, '/finance/monthly_calculation.dart'),
              ),
              AnimatedSquare(
                icon: Icons.list,
                label: 'Cadastrar despesas',
                onTap: () => Navigator.pushNamed(context, '/finance/register_expenses.dart'),
              ),
              // pode adicionar mais cards aqui se quiser
            ],
          );
        },
      ),
    );
  }
}
