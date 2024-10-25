import 'package:flutter/material.dart';

class Adding extends StatefulWidget {
  const Adding({super.key});

  @override
  State<Adding> createState() => _AddingState();
}

class _AddingState extends State<Adding> {

  String drop1 = 'Potholes';  
  String drop2 = 'BMC';       

  
  List<String> list1 = [
    'Potholes',
    'Stray dogs',
    'Street light malfunctioning',
    'Water Logging',
  ];
  
  List<String> list2 = [
    'BMC',
    'Garbage Department',
    'Animal Control',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding Problems'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First Dropdown
            DropdownButton<String>(
              value: drop1,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              onChanged: (String? newValue) {
                setState(() {
                  drop1 = newValue!;
                });
              },
              items: list1.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20), 
            
            DropdownButton<String>(
              value: drop2,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              onChanged: (String? newValue) {
                setState(() {
                  drop2 = newValue!;
                });
              },
              items: list2.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
