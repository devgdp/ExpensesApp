import 'dart:math';

import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../components/transaction_form.dart';
import '../components/transaction_list.dart';
import '../components/chart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // * Definindo Lista de transações Recebendo MODEL <Transaction>
  final List<Transaction> _transactions = [
    // * Cadastrando uma transação
    // Transaction(
    //   id: 't0',
    //   title: 'Conta antiga',
    //   value: 400.00,
    //   date: DateTime.now().subtract(const Duration(days: 33)),
    // ),
  ];

  // * Definindo Limite de Dias para calculo semanal no gráfico
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  // * Adicionando uma nova transação a Lista _transactions
  _addTransaction(
      String titleTransaction, double currencyTransaction, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: titleTransaction,
      value: currencyTransaction,
      date: date,
    );

    // * Atualizando Estado da Aplicação
    setState(() {
      _transactions.add(newTransaction);
    });

    // * Fechar Modal Formulário Após Cadastro da nova transação
    Navigator.of(context).pop();
  }

  // * Excluindo uma Transação
  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  // * Abrir Modal Formulário de Cadastro da nova transação
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            // * Chamando Modal de Cadastro da nova transação
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: Chart(_recentTransactions),
            ),
            TransactionList(_transactions, _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // * Chamando Modal de Cadastro da nova transação
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
