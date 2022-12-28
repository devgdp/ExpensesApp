// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onSubmit, {super.key});

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  // * Capturando dados do formulário
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  // * Função para cadastrar transações
  _submitForm() {
    final titleTransaction = _titleController.text;
    final currencyTransaction = double.tryParse(_valueController.text) ?? 0.0;

    // * Validando se algum campo do formulário esta Vazio
    if (titleTransaction.isEmpty ||
        currencyTransaction <= 0 ||
        _selectedDate == null) {
      return;
    }
    // * Armazenando informações digitadas
    widget.onSubmit(titleTransaction, currencyTransaction, _selectedDate!);
  }

  // * Exibindo Modal para seleção da DATA
  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                ),
                onSubmitted: (_) => _submitForm(),
              ),
              TextField(
                controller: _valueController,
                decoration: const InputDecoration(
                  labelText: 'Valor R\$',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        // * Comparando se há alguma data selecionada
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data Selecionada ${DateFormat('dd/MM/y').format(_selectedDate!)}',
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary),
                      onPressed: _showDatePicker,
                      child: const Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    child: const Text(
                      'Nova Transação',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
