import 'package:expense_controller/models/transaction.dart';
import 'package:expense_controller/styles/global_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.initialDate,
    required this.finalDate,
    required this.transactions,
  });

  final DateTime initialDate;
  final DateTime finalDate;
  final List<Transaction> transactions;

  String get valueTotalTransactions {
    double total =
        transactions.fold(0, (acc, transaction) => acc + transaction.value!);

    return "R\$ ${total.toStringAsFixed(2)}";
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "De ",
                        style: textBoldGray(size: 14),
                      ),
                      Text(
                        DateFormat('dd/MM/yy').format(initialDate),
                        style: textBoldPrimary(context: context, size: 14),
                      ),
                      Text(
                        " até ",
                        style: textBoldGray(size: 14),
                      ),
                      Text(
                        DateFormat("dd/MM/yy").format(finalDate),
                        style: textBoldPrimary(context: context, size: 14),
                      ),
                    ],
                  ),
                  separator(height: 5),
                  Row(
                    children: [
                      Text(
                        "Total de Despesas: ",
                        style: textBoldGray(size: 16),
                      ),
                      Text(
                        valueTotalTransactions,
                        style: textBoldPrimary(context: context, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
