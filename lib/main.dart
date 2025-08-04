import 'package:flutter/material.dart';
import 'package:orballe/Home/homePage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orballe',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        cardColor: Colors.white,
        primaryColor: const Color(0xFF1A73E8),
        textTheme: ThemeData.light().textTheme.apply(bodyColor: const Color(0xFF0F172A)),
        
        fontFamily: 'SpaceGrotesk',
        appBarTheme: AppBarTheme(
          shadowColor: Colors.black,
          elevation: 1,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          // automaticallyImplyLeading: false
        )
      ),
        
      home: const HomePage(),
    );
  }
}
