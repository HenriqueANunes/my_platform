import 'package:flutter/material.dart';
import '../widgets/animated_square.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Cabeçalho com sombra e tema escuro
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: theme.appBarTheme.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    "Meu App",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.iconTheme.color,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

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
                        onTap: () => Navigator.pushNamed(context, '/finance'),
                      ),
                      AnimatedSquare(
                        icon: Icons.person,
                        label: 'Perfil',
                        onTap: () {},
                      ),
                      AnimatedSquare(
                        icon: Icons.settings,
                        label: 'Configurações',
                        onTap: () {},
                      ),
                      AnimatedSquare(
                        icon: Icons.info,
                        label: 'Sobre',
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
      ),
    );
  }
}
