import 'package:flutter/material.dart';
import 'package:flutter_worldtime/presentation/pages/clock_page.dart';
import 'package:flutter_worldtime/presentation/pages/time_zones_page.dart';

class AppRoutes {
  static const String timezonesPage = 'timezones_page';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case timezonesPage:
        return _buildRoute(TimezonesPage(), settings);
      default:
        return _buildRoute(ClockPage(), settings);
    }
  }

  static _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
