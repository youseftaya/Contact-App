import 'package:flutter/material.dart';

import '../data/model/contact_model.dart';
import '../view/screens/add_contact_screen.dart';
import '../view/screens/home_screen.dart';
import '../view/screens/profile_screen.dart';

class AppRoutes {
  static const String profile = '/profile';
  static const String home = '/';
  static const String addContact = '/add-contact';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case addContact:
        final contact = settings.arguments as ContactModel?;

        return MaterialPageRoute(
          builder: (_) => AddContactScreen(
            contact: contact,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(
            isDarkMode: true,
            onThemeChanged: _emptyThemeCallback,
          ),
        );
    }
  }

  static void _emptyThemeCallback(bool value) {}
}