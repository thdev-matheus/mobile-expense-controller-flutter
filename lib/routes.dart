import 'package:expense_controller/pages/Home/home_page.dart';
import 'package:expense_controller/pages/Loading/loading_page.dart';
import 'package:expense_controller/pages/Theme/theme_page.dart';

class Routes {
  static routesList() {
    return {
      "/": (context) => const LoadingPage(),
      "/home": (context) => const MyHomePage(),
      "/theme": (context) => const ThemePage(),
    };
  }
}
