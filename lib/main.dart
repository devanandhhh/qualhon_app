import 'package:flutter/material.dart';
import 'package:qualhon_app/presentation/pages/first_screen/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qualhon App',
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
      
    );
  }
}
