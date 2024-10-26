import 'package:flutter/material.dart';

void main() {
  runApp(ChatbotApp());
}

class ChatbotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _messages = []; // Stores chat messages

  // Simple chatbot response logic
  String getResponse(String input) {
    input = input.toLowerCase();
    if (input.contains('services')) {
      return 'We offer water supply, waste management, and health services.';
    } else if (input.contains('complaint')) {
      return 'You can file a complaint through the MCGM website.';
    } else if (input.contains('health')) {
      return 'Municipal hospitals provide various health services.';
    } else {
      return 'Sorry, I did not understand your question. Please try again.';
    }
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add('You: ${_controller.text}');
      String response = getResponse(_controller.text);
      _messages.add('Bot: $response');
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
