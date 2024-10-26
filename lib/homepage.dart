// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.home),
            SizedBox(width: 20),
            Text("Hello"),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(left: 2000),),
                 Text("Click below to enter your problem"),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/problem');
                  },
                  child: const Text("Enter"),
                ),
                const SizedBox(height: 20),
                const Text("Click below to see existing problems"),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: const Text("View"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), 
          const Text(
            "tes",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20), 
          
          
        ],
      ),
    );
  }
}
