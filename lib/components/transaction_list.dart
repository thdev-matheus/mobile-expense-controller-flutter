import 'package:expense_controller/components/transaction_card.dart';
import 'package:expense_controller/models/transaction.dart';
import 'package:expense_controller/styles/global_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.transactions,
    required this.removeTransaction,
    required this.maxHeight,
  });

  final double maxHeight;
  final List<Transaction> transactions;
  final void Function(int) removeTransaction;

  String formatValueToBrCurrency(double value) {
    String brValue = NumberFormat.currency(
      locale: "pt-BRL",
      name: "R\$",
    ).format(value);

    return brValue;
  }

  String _formatValue(double value) {
    if (value < 1000) {
      return value.toStringAsFixed(2);
    } else if (value < 1000000) {
      return "${(value / 1000).toStringAsFixed(1)}K";
    } else {
      return "${(value / 1000000).toStringAsFixed(2)}M";
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 5,
          color: white,
          child: transactions.isEmpty
              ? SizedBox(
                  height: maxHeight * 0.6,
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: marginPaddingSymetric(vertical: 5),
                        child: Text(
                          "Nenhuma Transação cadastrada",
                          textAlign: TextAlign.center,
                          style: textBoldGray(size: 16),
                        ),
                      ),
                      separator(height: maxHeight * 0.03),
                      SizedBox(
                        height: maxHeight * 0.4,
                        child: Image.asset(
                          "assets/images/waiting.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox(
                  height: maxHeight * 0.6,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final tr = transactions[index];
                      return TransactionCard(
                        onAction: () => removeTransaction(index),
                        valueText: "R\$ ${_formatValue(tr.value!)}",
                        trTitle: tr.title!,
                        trSubTitle: DateFormat("d MMM y")
                            .format(DateTime.parse(tr.date!)),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
