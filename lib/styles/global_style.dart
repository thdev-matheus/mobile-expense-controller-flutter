import 'package:flutter/material.dart';

// widgets
Widget separator({
  double? height,
  double? width,
}) =>
    SizedBox(
      height: height,
      width: width,
    );

// ===================================================================

// margins and paddings double
EdgeInsets marginPaddingOnly({
  double? top,
  double? right,
  double? bottom,
  double? left,
}) =>
    EdgeInsets.only(
      top: top ?? 0,
      right: right ?? 0,
      bottom: bottom ?? 0,
      left: left ?? 0,
    );

EdgeInsets marginPaddingSymetric({double? vertical, double? horizontal}) =>
    EdgeInsets.symmetric(
      vertical: vertical ?? 0,
      horizontal: horizontal ?? 0,
    );

EdgeInsets marginPaddingAll({
  double? size,
}) =>
    EdgeInsets.all(size ?? 0);

// =====================================================================

// colors
// base
const Color black = Colors.black87;
const Color gray = Colors.black54;
const Color lightGray = Colors.white70;
const Color white = Colors.white;
const Color offWhite = Color.fromARGB(247, 243, 243, 243);

// primary
const Color purple = Colors.purple;
Color blue = Colors.blue[900]!;
Color red = Colors.red[900]!;

// secondary
const Color amber = Colors.amber;
Color ligthBlue = Colors.lightBlue[50]!;
Color ligthRed = Colors.red[100]!;

// ================================================================

// text styles

TextStyle textBoldWhite({
  required double size,
}) =>
    TextStyle(
      fontFamily: 'Quicksand',
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: offWhite,
    );

TextStyle textBoldBlack({
  required double size,
}) =>
    TextStyle(
      fontFamily: 'Quicksand',
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: black,
    );

TextStyle textBoldGray({
  required double size,
}) =>
    TextStyle(
      fontFamily: 'Quicksand',
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: gray,
    );

TextStyle textBoldPurple({
  required double size,
}) =>
    TextStyle(
      fontFamily: 'Quicksand',
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: purple,
    );

TextStyle textBoldBlue({
  required double size,
}) =>
    TextStyle(
      fontFamily: 'Quicksand',
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: blue,
    );

TextStyle textBoldRed({
  required double size,
}) =>
    TextStyle(
      fontFamily: 'Quicksand',
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: red,
    );

TextStyle textBoldPrimary({
  required BuildContext context,
  required double size,
}) =>
    TextStyle(
      fontFamily: 'Quicksand',
      fontWeight: FontWeight.bold,
      fontSize: size,
      color: Theme.of(context).colorScheme.primary,
    );

TextStyle textBoldSecondary({
  required BuildContext context,
  required double size,
}) =>
    TextStyle(
      fontFamily: 'Quicksand',
      fontWeight: FontWeight.bold,
      fontSize: size,
      color: Theme.of(context).colorScheme.secondary,
    );

// =============================================================================

// button styles
ButtonStyle elevatedButtonStyle({
  bool primary = true,
  required BuildContext context,
}) {
  if (!primary) {
    return ButtonStyle(
      elevation: const MaterialStatePropertyAll(5),
      backgroundColor: const MaterialStatePropertyAll(offWhite),
      padding: MaterialStatePropertyAll(
          marginPaddingSymetric(vertical: 5, horizontal: 10)),
      side: MaterialStatePropertyAll(
        BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
    );
  }

  return ButtonStyle(
    elevation: const MaterialStatePropertyAll(5),
    backgroundColor:
        MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
    padding: MaterialStatePropertyAll(
        marginPaddingSymetric(vertical: 5, horizontal: 10)),
    textStyle:
        MaterialStatePropertyAll(textBoldSecondary(context: context, size: 10)),
  );
}

ButtonStyle customElevatedButtonStyle({
  required BuildContext context,
  required Color fillColor,
  required Color borderColor,
  required double width,
  required double height,
}) {
  return ButtonStyle(
      elevation: const MaterialStatePropertyAll(5),
      backgroundColor: MaterialStatePropertyAll(fillColor),
      padding: MaterialStatePropertyAll(
          marginPaddingSymetric(vertical: 5, horizontal: 10)),
      side: MaterialStatePropertyAll(
        BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      fixedSize: MaterialStatePropertyAll(Size(width, height)));
}
