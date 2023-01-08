import 'package:expense_controller/styles/global_style.dart';
import 'package:flutter/material.dart';

class Filters extends StatelessWidget {
  const Filters({
    super.key,
    required this.clearFilters,
    required this.openModal,
  });

  final void Function() clearFilters;
  final void Function(BuildContext) openModal;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: elevatedButtonStyle(context: context, primary: false),
              onPressed: () => clearFilters(),
              child: Text(
                "Remover Filtros",
                style: textBoldPrimary(context: context, size: 12),
              ),
            ),
            separator(width: 10),
            ElevatedButton(
              style: elevatedButtonStyle(context: context),
              onPressed: () => openModal(context),
              child: const Icon(Icons.filter_list_outlined),
            ),
          ],
        );
      },
    );
  }
}
