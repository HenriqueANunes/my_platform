import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<StatefulWidget> createState() => ExpenseFormState();
}

class ExpenseFormState extends State<ExpenseForm> {
  final _title = TextEditingController();
  final _amount = TextEditingController();

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
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Nome da despesa',
              ),
            ),
            const SizedBox(height: 20.0),
            // Amount
            TextField(
              controller: _amount,
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
              onPressed: () {
                print('salvou');
              },
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
}
