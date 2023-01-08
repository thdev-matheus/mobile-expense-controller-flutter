part of "./home_page.dart";

class ScreenController {
  Map<String, dynamic> getRouteParams(BuildContext context) {
    return ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  }
}
