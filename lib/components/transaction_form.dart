// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onSubmit, {super.key});
  final void Function(String, double) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  // Capturando dados do formulário
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final titleTransaction = titleController.text;
    final currencyTransaction = double.tryParse(valueController.text) ?? 0.0;

    if (titleTransaction.isEmpty || currencyTransaction <= 0) {
      return;
    }
    widget.onSubmit(titleTransaction, currencyTransaction);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Titulo',
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(
                labelText: 'Valor R\$',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                  ),
                  child: const Text(
                    'Nova Transação',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
