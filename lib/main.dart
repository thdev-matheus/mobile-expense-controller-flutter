import 'package:expense_controller/helpers/device_storage.dart';
import 'package:expense_controller/routes.dart';
import 'package:expense_controller/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  final ColorTheme _theme = ColorTheme();
  final DeviceStorage _device = DeviceStorage();

  int themeNumber = 0;

  void setTheme() {
    _device.readData().then((data) {
      if (data["theme"] != null) {
        if (mounted) {
          setState(() {
            themeNumber = data["theme"];
          });
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    setTheme();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Setando a orientação fixa da aplicação
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

    return GestureDetector(
      onTap: () => {
        FocusScope.of(context).requestFocus(FocusNode()),
      },
      child: MaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [Locale("pt", "BR")],
        theme: _theme.themeData(themeNumber),
        debugShowCheckedModeBanner: false,
        routes: Routes.routesList(),
        initialRoute: "/",
      ),
    );
  }
}
