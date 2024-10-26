import 'dart:io'; // Import this for File handling
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? selectedFilePath;
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding Problems'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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

              // Description TextField
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              // File Picker Button
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();

                  if (result != null) {
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

              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  CollectionReference problems = FirebaseFirestore.instance.collection('problems');
                  String description = descriptionController.text;
                  String selectedOption1 = drop1;
                  String selectedOption2 = drop2;

                    problems.add({
                      'description': description,
                      'option1': selectedOption1,
                      'option2': selectedOption2,
                      'file_path': selectedFilePath,
                    });

                  print('Selected Options: $selectedOption1, $selectedOption2');
                  print('Description: $description');
                  print('File Path: $selectedFilePath');


                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data submitted successfully!')),
                  );

                  setState(() {
                    selectedFilePath = null;
                    descriptionController.clear();
                    drop1 = list1[0];
                    drop2 = list2[0];
                  });
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
