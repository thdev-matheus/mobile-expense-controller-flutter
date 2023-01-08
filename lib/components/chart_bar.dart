import 'package:expense_controller/styles/global_style.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  final String label;
  final double value;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  "${(percentage * 100).toStringAsFixed(1)}%",
                  style: percentage == 0
                      ? textBoldGray(size: 3)
                      : textBoldPrimary(context: context, size: 3),
                ),
              ),
            ),
            separator(height: constraints.maxHeight * 0.05),
            SizedBox(
              height: constraints.maxHeight * 0.60,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1.0,
                      ),
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
            separator(height: constraints.maxHeight * 0.05),
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: Text(
                label,
                style: percentage == 0
                    ? textBoldGray(size: 16)
                    : textBoldPrimary(context: context, size: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
