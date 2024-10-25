import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mumbaihacks/firebase_options.dart';
import 'package:mumbaihacks/homepage.dart'; 
import 'package:mumbaihacks/problem.dart'; 


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
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
