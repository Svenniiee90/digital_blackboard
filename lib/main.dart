import 'package:flutter/material.dart';
import 'src/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digitales Blackboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSwatch(backgroundColor: Colors.black38),
        useMaterial3: true,
      ),
      home: const Home(title: 'Blackboard',),
    );
  }
}

