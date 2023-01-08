// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:expense_controller/components/chart.dart';
import 'package:expense_controller/components/details.dart';
import 'package:expense_controller/components/filters.dart';
import 'package:expense_controller/components/transaction_filters.dart';
import 'package:expense_controller/components/transaction_form.dart';
import 'package:expense_controller/components/transaction_list.dart';
import 'package:expense_controller/helpers/device_storage.dart';
import 'package:expense_controller/models/transaction.dart';
import 'package:expense_controller/styles/global_style.dart';
import 'package:flutter/material.dart';

part "screen_controller.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final ScreenController _controller = ScreenController();
  final DeviceStorage device = DeviceStorage();
  late List<Transaction> _transactions;
  late List<Transaction> transactionsToView;
  DateTime initialDate = DateTime.now().subtract(
    const Duration(days: 7),
  );

  DateTime finalDate = DateTime.now().add(
    const Duration(days: 1),
  );

  List<Transaction> getTransactions() {
    List<Transaction> sortedTransactions = _transactions.where((tr) {
      DateTime trDate = DateTime.parse(tr.date!);
      return trDate.isAfter(initialDate) && trDate.isBefore(finalDate);
    }).toList();

    sortedTransactions.sort(
      (a, b) {
        return DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!));
      },
    );

    return sortedTransactions;
  }

  void filterTransactions({required DateTime init, required DateTime fin}) {
    setState(() {
      initialDate = init.subtract(const Duration(days: 1));
      finalDate = fin.add(const Duration(days: 1));

      transactionsToView = getTransactions();
    });
  }

  Future<void> saveDevice() async {
    Map<String, dynamic> data = {
      "transactions": [..._transactions.map((t) => t.toJson())],
    };

    await device.storeData(data);
  }

  void _addTransation(String title, double value, DateTime date) async {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date.toString(),
    );

    setState(() {
      _transactions.add(newTransaction);
      transactionsToView = getTransactions();
    });

    await saveDevice();

    Navigator.of(context).pop();
  }

  void clearFilters() {
    setState(() {
      initialDate = DateTime.now().subtract(
        const Duration(days: 6),
      );

      finalDate = DateTime.now();
    });

    filterTransactions(init: initialDate, fin: finalDate);
  }

  void _removeTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
      transactionsToView = getTransactions();
    });

    saveDevice();
  }

  void _openFiltersModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return TransactionFilters(
          initialDate: initialDate.add(const Duration(days: 1)),
          finalDate: finalDate.subtract(const Duration(days: 1)),
          onAction: filterTransactions,
        );
      },
    );
  }

  void _openTransactionModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: _addTransation,
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    Map<String, dynamic> params = _controller.getRouteParams(context);

    if (mounted) {
      setState(() {
        _transactions = params["transactions"];
        transactionsToView = getTransactions();
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text("Despesas Pessoais"),
      actions: [
        if (isLandScape)
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.add),
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () => _openTransactionModal(context)),
              IconButton(
                icon: Icon(_showChart ? Icons.list : Icons.pie_chart),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () => setState(
                  () {
                    _showChart = !_showChart;
                  },
                ),
              ),
            ],
          ),
        IconButton(
          icon: const Icon(Icons.color_lens_outlined),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () => Navigator.of(context).pushNamed("/theme"),
        ),
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return SafeArea(
      child: Scaffold(
        backgroundColor: offWhite,
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_showChart || !isLandScape)
                SizedBox(
                  height: availableHeight * (isLandScape ? 0.7 : 0.25),
                  child: Chart(
                    transactionsToView: transactionsToView,
                    finalDate: finalDate.subtract(const Duration(days: 1)),
                  ),
                ),
              if (!_showChart || !isLandScape)
                SizedBox(
                  height:
                      isLandScape ? availableHeight : availableHeight * 0.75,
                  child: Padding(
                    padding: marginPaddingAll(size: 10),
                    child: Column(
                      children: [
                        Filters(
                          clearFilters: clearFilters,
                          openModal: _openFiltersModal,
                        ),
                        Details(
                          initialDate: initialDate.add(const Duration(days: 1)),
                          finalDate:
                              finalDate.subtract(const Duration(days: 1)),
                          transactions: transactionsToView,
                        ),
                        TransactionList(
                          maxHeight: availableHeight * 0.75,
                          transactions: transactionsToView,
                          removeTransaction: _removeTransaction,
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
        floatingActionButton: !isLandScape
            ? FloatingActionButton(
                mini: true,
                elevation: 5,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.add),
                onPressed: () => _openTransactionModal(context),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
