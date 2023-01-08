// ignore_for_file: use_build_context_synchronously

import 'package:expense_controller/components/square_button.dart';
import 'package:expense_controller/helpers/device_storage.dart';
import 'package:expense_controller/main.dart';
import 'package:expense_controller/styles/global_style.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  final DeviceStorage _device = DeviceStorage();

  int currentTheme = 0;
  String currentThemeName = "";
  TextStyle themeStyle = textBoldGray(size: 20);

  void setCurrentThemeName() {
    switch (currentTheme) {
      case 0:
        setState(() {
          currentThemeName = "Roxo";
          themeStyle = textBoldPurple(size: 20);
        });
        break;
      case 1:
        setState(() {
          currentThemeName = "Azul";
          themeStyle = textBoldBlue(size: 20);
        });
        break;
      case 2:
        setState(() {
          currentThemeName = "vermelho";
          themeStyle = textBoldRed(size: 20);
        });
        break;
      default:
    }
  }

  void getCurrentTheme() async {
    Map<String, dynamic> deviceData = await _device.readData();

    setState(() {
      currentTheme = deviceData["theme"] ?? 0;
    });
  }

  void setCurrentTheme(int value) {
    setState(() {
      currentTheme = value;
    });

    setCurrentThemeName();
  }

  void setTheme() async {
    Map<String, dynamic> deviceData = await _device.readData();

    deviceData["theme"] = currentTheme;

    await _device.storeData(deviceData);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const ExpensesApp(),
        ),
        ((route) => false));
  }

  @override
  void didChangeDependencies() {
    if (mounted) {
      getCurrentTheme();
      setCurrentThemeName();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGray,
        body: Container(
          padding: marginPaddingAll(size: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              separator(height: 10),
              Text(
                "Customize seu App",
                style: textBoldPrimary(context: context, size: 25),
              ),
              separator(height: 20),
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  SquareButton(
                    borderColor: amber,
                    fillColor: purple,
                    height: 80,
                    width: 120,
                    onAction: () => setCurrentTheme(0),
                    child: Text(
                      "Roxo",
                      style: textBoldWhite(size: 16),
                    ),
                  ),
                  SquareButton(
                    borderColor: ligthBlue,
                    fillColor: blue,
                    height: 80,
                    width: 120,
                    onAction: () => setCurrentTheme(1),
                    child: Text(
                      "Azul",
                      style: textBoldWhite(size: 16),
                    ),
                  ),
                  SquareButton(
                    borderColor: ligthRed,
                    fillColor: red,
                    height: 80,
                    width: 120,
                    onAction: () => setCurrentTheme(2),
                    child: Text(
                      "Vermelho",
                      style: textBoldWhite(size: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: marginPaddingSymetric(horizontal: 50, vertical: 20),
          width: MediaQuery.of(context).size.width - 100,
          height: 80,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tema selecionado: ",
                    style: textBoldGray(size: 20),
                  ),
                  Text(
                    currentThemeName,
                    style: themeStyle,
                  ),
                ],
              ),
              separator(height: 10),
              ElevatedButton(
                style: elevatedButtonStyle(context: context),
                onPressed: setTheme,
                child: Text(
                  "Definir Tema",
                  style: textBoldSecondary(context: context, size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
