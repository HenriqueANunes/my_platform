import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_platform/models/expense_model.dart';
import 'package:my_platform/services/expense_service.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<StatefulWidget> createState() => ExpenseFormState();
}

class ExpenseFormState extends State<ExpenseForm> {
  final _name = TextEditingController();
  final _value = TextEditingController();

  DateTimeRange? _dateRange;

  @override
  Widget build(BuildContext context) {
    final dat_ini = _dateRange?.start;
    final dat_fim = _dateRange?.end;

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
            ),
            const SizedBox(height: 20.0),
            // Initial Date
            Row(
              children: [
                Expanded(
                  child: Text(
                    dat_ini != null && dat_fim != null
                        ? 'Data incial: ${DateFormat('dd/MM/yyyy').format(dat_ini)}\n'
                              'Data final: ${DateFormat('dd/MM/yyyy').format(dat_fim)}'
                        : 'Selecione uma data',
                  ),
                ),
                IconButton(onPressed: () => pickDateRange(), icon: const Icon(Icons.calendar_month)),
              ],
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

  Future pickDateRange() async {
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

  _saveExpense() async {
    final expense = ExpenseModel(
      name: _name.text,
      value: double.parse(_value.text),
      type: 'exit',
    );
    await ExpenseService().saveExpense(expenseObj: expense);
  }
}
