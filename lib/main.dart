import 'package:flutter/material.dart';
import 'package:mumbaihacks/homepage.dart'; 
import 'package:mumbaihacks/problem.dart'; 


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Problem Solver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homepage(),
      routes: {
        '/home': (context)=>Homepage(),
        '/problem':(context)=>Adding(),
      }, 
    );
  }
}
