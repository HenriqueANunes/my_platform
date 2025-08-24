import 'package:flutter/material.dart';
import '../widgets/animated_square.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meu App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.iconTheme.color,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Column(
        children: [
          // Grade de botões
          Expanded(
            child: LayoutBuilder(
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
                      label: 'Finanças',
                      onTap: () => Navigator.pushNamed(context, '/finance/finance.dart'),
                    ),
                    AnimatedSquare(
                      icon: Icons.settings,
                      label: 'A fazer...',
                      onTap: () {},
                    ),
                    // pode adicionar mais cards aqui se quiser
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
