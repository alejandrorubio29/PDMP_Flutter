import 'package:flutter/material.dart';
import 'package:tasca4/screens/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        // La pàgina inicial del giny MaterialApp
        // és el giny Pantalla1.
        debugShowCheckedModeBanner: false,
        home: Login());
  }
}
