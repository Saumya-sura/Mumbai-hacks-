import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isLoading = false;

  // Replace with your Hugging Face API token
  final String apiToken = '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';

  // Function to send a message to the Llama model on Hugging Face
  Future<void> sendMessage(String userMessage) async {
    setState(() {
      isLoading = true;
      messages.add({'sender': 'User', 'message': userMessage});
    });

    final url = Uri.parse('https://api-inference.huggingface.co/models/meta-llama/Llama-3.2-1B');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"inputs": userMessage}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final botMessage = data['generated_text'] ?? 'Sorry, I did not understand that.';

      setState(() {
        messages.add({'sender': 'Llama', 'message': botMessage});
        isLoading = false;
      });
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}'); // Log the full response body

      setState(() {
        messages.add({'sender': 'Llama', 'message': 'Error fetching response.'});
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Llama Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['sender'] == 'User';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message['message'] ?? ''),
                  ),
                );
              },
            ),
          ),
          if (isLoading) CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final query = _controller.text.trim();
                    if (query.isNotEmpty) {
                      sendMessage(query);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
