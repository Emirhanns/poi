import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/map_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const LoginScreen(),
      '/map': (context) => const MapScreen(),  // Harita ekranını ekleyin
    };
  }
}