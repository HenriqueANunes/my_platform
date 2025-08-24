import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_platform/models/expense_model.dart';
import 'package:my_platform/services/currency_formatter.dart';
import 'package:my_platform/services/expense_service.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<StatefulWidget> createState() => ExpenseFormState();
}

class ExpenseFormState extends State<ExpenseForm> {
  final _name = TextEditingController();
  final _value = TextEditingController();
  bool _isCredit = false;

  DateTimeRange? _dateRange;
  @override

  void initState() {
    super.initState();
    _value.text = 'R\$ 0,00';
  }

  @override
  Widget build(BuildContext context) {
    final dateStart = _dateRange?.start;
    final dateEnd = _dateRange?.end;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Title
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Nome da despesa',
              ),
            ),
            const SizedBox(height: 20.0),
            // Amount
            TextField(
              controller: _value,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor da despesa',
              ),
              inputFormatters: [
                CurrencyInputFormatter(),
              ],
            ),
            const SizedBox(height: 20.0),
            // Initial Date
            Row(
              children: [
                Expanded(
                  child: Text(
                    dateStart != null && dateEnd != null
                        ? 'Data incial: ${DateFormat('dd/MM/yyyy').format(dateStart)}\n'
                              'Data final: ${DateFormat('dd/MM/yyyy').format(dateEnd)}'
                        : 'Selecione uma data',
                  ),
                ),
                IconButton(onPressed: () => pickDateRange(), icon: const Icon(Icons.calendar_month)),
              ],
            ),
            const SizedBox(height: 20.0),
            CheckboxListTile(
              title: Text('É Crédito?'),
              value: _isCredit,
              onChanged: (value) {
                setState(() {
                  _isCredit = value!;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: _saveExpense,
              label: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) {
      return;
    }

    setState(() => _dateRange = newDateRange);
  }

  _saveExpense() {
    final dateStart = _dateRange?.start;
    final dateEnd = _dateRange?.end;
    final cleanValue = _value.text
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .trim();

    final expense = ExpenseModel(
      name: _name.text,
      value: double.parse(cleanValue),
      date_start: dateStart,
      date_end: dateEnd,
      type: 'exit',
      isCredit: _isCredit,
    );

    // add it to database.
    ExpenseService().saveExpense(expenseObj: expense);

    // close the bottomsheet
    Navigator.of(context).pop();
  }
}
