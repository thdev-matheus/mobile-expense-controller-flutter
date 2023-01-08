import 'package:expense_controller/styles/global_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionFilters extends StatefulWidget {
  const TransactionFilters({
    super.key,
    required this.initialDate,
    required this.finalDate,
    required this.onAction,
  });

  final DateTime initialDate;
  final DateTime finalDate;
  final void Function({required DateTime fin, required DateTime init}) onAction;

  @override
  State<TransactionFilters> createState() => _TransactionFiltersState();
}

class _TransactionFiltersState extends State<TransactionFilters> {
  late DateTime selectedInitialDate;
  late DateTime selectedFinalDate;

  _showInitialDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        selectedInitialDate = pickedDate ?? selectedInitialDate;
      });
    });
  }

  _showFinalDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        selectedFinalDate = pickedDate ?? selectedFinalDate;
      });
    });
  }

  @override
  void didChangeDependencies() {
    if (mounted) {
      setState(() {
        selectedInitialDate = widget.initialDate;
        selectedFinalDate = widget.finalDate;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: marginPaddingAll(
          size: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            separator(height: 10),
            Text(
              "Filtrar por data",
              style: textBoldBlack(size: 25),
            ),
            separator(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Data inicial: ",
                      style: textBoldBlack(size: 14),
                    ),
                    Text(
                      DateFormat('dd/MM/yy').format(selectedInitialDate),
                      style: textBoldPrimary(context: context, size: 14),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: _showInitialDatePicker,
                  child: Text(
                    "Selecionar Data",
                    style: textBoldPrimary(context: context, size: 14),
                  ),
                )
              ],
            ),
            separator(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Data final: ",
                      style: textBoldBlack(size: 14),
                    ),
                    Text(
                      DateFormat('dd/MM/yy').format(selectedFinalDate),
                      style: textBoldPrimary(context: context, size: 14),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: _showFinalDatePicker,
                  child: Text(
                    "Selecionar Data",
                    style: textBoldPrimary(context: context, size: 14),
                  ),
                )
              ],
            ),
            separator(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    child: const Text("Filtrar"),
                    onPressed: () {
                      widget.onAction(
                        init: selectedInitialDate,
                        fin: selectedFinalDate,
                      );

                      Navigator.of(context).pop();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
