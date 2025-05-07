import 'package:flutter/material.dart';
import 'package:ttb_restapi/screens/home_screen.dart';
import 'package:ttb_restapi/screens/mainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(centerTitle: true),
      ),
      home:Mainscreen()
    );
  }
}

