import 'package:expense_controller/styles/global_style.dart';
import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    super.key,
    required this.borderColor,
    required this.fillColor,
    required this.height,
    required this.width,
    required this.child,
    required this.onAction,
  });

  final Color fillColor;
  final Color borderColor;
  final double width;
  final double height;
  final Widget child;
  final void Function() onAction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: customElevatedButtonStyle(
        context: context,
        fillColor: fillColor,
        borderColor: borderColor,
        width: width,
        height: height,
      ),
      onPressed: onAction,
      child: child,
    );
  }
}
