import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load preferences from SharedPreferences
  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool("isDarkMode") ?? false;
      isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    });
  }

  // Toggle dark mode and save preference
  void toggleDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = value;
    });
    await prefs.setBool("isDarkMode", value);
  }

  // Handle successful login and save preference
  void onLoginSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = true;
    });
    await prefs.setBool("isLoggedIn", true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home:
          isLoggedIn
              ? HomeScreen(
                isDarkMode: isDarkMode,
                onThemeChanged: toggleDarkMode,
              )
              : LoginScreen(onLoginSuccess: onLoginSuccess),
    );
  }
}
