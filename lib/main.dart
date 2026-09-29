import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'core/app_routes.dart';
import 'core/app_theme.dart';
import 'view/screens/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const FirebaseApp());
}

class FirebaseApp extends StatefulWidget {
  const FirebaseApp({super.key});

  @override
  State<FirebaseApp> createState() => _FirebaseAppState();
}

class _FirebaseAppState extends State<FirebaseApp> {
  ThemeMode themeMode = ThemeMode.dark;

  void changeTheme(bool isDark) {
    setState(() {
      themeMode = isDark
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts App',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      initialRoute: AppRoutes.profile,

      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.profile) {
          return MaterialPageRoute(
            builder: (_) => ProfileScreen(
              isDarkMode: themeMode == ThemeMode.dark,
              onThemeChanged: changeTheme,
            ),
          );
        }

        return AppRoutes.generateRoute(settings);
      },
    );
  }
}