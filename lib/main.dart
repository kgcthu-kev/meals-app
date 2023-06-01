import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealapp/pages/tabs_page.dart';

void main() {
  runApp(const MyApp());
}

final theme = ThemeData(
    textTheme: GoogleFonts.latoTextTheme(),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 131, 57, 0),
        brightness: Brightness.dark));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TabsPage(),
      theme: theme,
    );
  }
}
