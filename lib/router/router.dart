import 'package:flutter/material.dart';
import 'package:push/models/models.dart';
import 'package:push/screens/screens.dart';

class AppRoutes {
  static const String initialRoute = "home";

  static final routes = <NavItem>[
    NavItem(
      route: "home",
      screen: const HomeScreen(),
    ),
    NavItem(
      route: "message",
      screen: const MessageScreen(),
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (final route in routes) {
      appRoutes.addAll(route.router);
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}
