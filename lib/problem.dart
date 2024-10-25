import 'dart:io'; // Import this for File handling
import 'package:file_picker/file_picker.dart';
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

  // Variable to hold the selected file path
  String? selectedFilePath;

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

            // Second Dropdown
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
            const SizedBox(height: 20),

            // File Picker Button
            ElevatedButton(
              onPressed: () async {
                // Open file picker
                FilePickerResult? result = await FilePicker.platform.pickFiles();

                if (result != null) {
                  // If a file is selected, get its path
                  selectedFilePath = result.files.single.path;
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('File selected: $selectedFilePath')),
                  );
                } else {
                 
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No file selected')),
                  );
                }
              },
              child: const Text("Pick a File"),
            ),

            
            if (selectedFilePath != null) 
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Selected File: $selectedFilePath',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
