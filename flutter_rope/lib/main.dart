import 'package:flutter/material.dart';
import 'package:flutter_spring/spring.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter Spring demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Spring(),
    );
  }
}
