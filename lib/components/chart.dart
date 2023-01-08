import 'package:expense_controller/components/chart_bar.dart';
import 'package:expense_controller/models/transaction.dart';
import 'package:expense_controller/styles/global_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
    required this.transactionsToView,
    required this.finalDate,
  });

  final List<Transaction> transactionsToView;
  final DateTime finalDate;

  String getBrWeekDay(String weekEnDay) {
    String day = "";

    switch (weekEnDay) {
      case "Mon":
        day = "Seg";
        break;
      case "Tue":
        day = "Ter";
        break;
      case "Wed":
        day = "Qua";
        break;
      case "Thu":
        day = "Qui";
        break;
      case "Fri":
        day = "Sex";
        break;
      case "Sat":
        day = "Sáb";
        break;
      case "Sun":
        day = "Dom";
        break;
    }

    return day;
  }

  List<Map<String, dynamic>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = finalDate.subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var tr in transactionsToView) {
        bool sameDay = DateTime.parse(tr.date!).day == weekDay.day;
        bool sameMonth = DateTime.parse(tr.date!).month == weekDay.month;
        bool sameYear = DateTime.parse(tr.date!).year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += tr.value!;
        }
      }
      return {
        "day": getBrWeekDay(DateFormat.E().format(weekDay)),
        "value": totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0, (acc, tr) {
      return acc + tr["value"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: marginPaddingAll(size: 20),
      child: Padding(
        padding: marginPaddingAll(size: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr["day"][0],
                value: tr["value"],
                percentage: (tr["value"] / _weekTotalValue) >= 0
                    ? tr["value"] / _weekTotalValue
                    : 0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
