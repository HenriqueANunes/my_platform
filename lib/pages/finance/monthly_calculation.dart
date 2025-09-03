import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_platform/services/currency_formatter.dart';
import 'package:my_platform/services/expense_service.dart';

class MonthlyCalculationPage extends StatefulWidget {
  const MonthlyCalculationPage({super.key});

  @override
  State<MonthlyCalculationPage> createState() => _State();
}

class _State extends State<MonthlyCalculationPage> {
  final _inflows = TextEditingController();
  final _credit = TextEditingController();
  final _other = TextEditingController();

  final _expenseObj = ExpenseService();
  late Future<double> _monthExpensesTotal;

  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _monthExpensesTotal = _expenseObj.getTotal(isCredit: false);

    _inflows.text = 'R\$ 0,00';
    _credit.text = 'R\$ 0,00';
    _other.text = 'R\$ 0,00';
  }

  Future<double> calculateLiquidIncome() async {
    final monthExpensesTotal  = await _monthExpensesTotal;
    final double totalExenses = double.parse(_credit.text) + double.parse(_other.text) + monthExpensesTotal;

    final liquidIncome = double.parse(_inflows.text) - totalExenses;
    return liquidIncome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculo Mensal'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _inflows,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Renda desse mes',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  CurrencyInputFormatter(),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _credit,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Fatura do cartão de crédito',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  CurrencyInputFormatter(),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _other,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Outras despesas',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  CurrencyInputFormatter(),
                ],
              ),
              const SizedBox(height: 20.0),
              FutureBuilder(
                future: _monthExpensesTotal,
                builder: (constext, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      final error = snapshot.error;
                      return Center(child: Text('$error'));
                    } else {
                      final monthExpensesTotal = TextEditingController();
                      monthExpensesTotal.text = _formatter.format(snapshot.data);

                      return  TextField(
                        controller: monthExpensesTotal,
                        decoration: const InputDecoration(
                          labelText: 'Total recorrente',
                          border: OutlineInputBorder(),
                        ),
                        enabled: false,
                      );
                    }
                  } else {
                    final monthExpensesTotal = TextEditingController();
                    monthExpensesTotal.text = _formatter.format(0.0);

                    return  TextField(
                      controller: monthExpensesTotal,
                      decoration: const InputDecoration(
                        labelText: 'Total recorrente',
                        border: OutlineInputBorder(),
                      ),
                      enabled: false,
                    );
                  }
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.calculate),
                label: Text('Calcular Renda líquida'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
