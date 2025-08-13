import 'package:flutter/material.dart';
import 'package:my_platform/pages/home.dart';
import 'package:my_platform/pages/finance/finance.dart';
import 'package:my_platform/pages/finance/monthly_calculation.dart';
import 'package:my_platform/pages/finance/register_expenses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardColor: const Color(0xFF1F1F1F),
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          bodyLarge: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: const Color(0xFF1E1E1E),
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/finance/finance.dart': (context) => const FinancePage(),
        '/finance/monthly_calculation.dart': (context) => const MonthlyCalculationPage(),
        '/finance/register_expenses.dart': (context) => const RegisterExpensesPage(),
      },
    );
  }
}
