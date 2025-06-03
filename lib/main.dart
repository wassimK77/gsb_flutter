import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application de Location',
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: Color(0xFFF4F4F4),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF555555),
          ),
          displaySmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF555555),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF333333),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF555555),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4CAF50),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xFFCCCCCC)),
          ),
          contentPadding: EdgeInsets.all(10),
        ),
      ),
      home: HomeScreen(), // Redirection vers HomeScreen
    );
  }
}