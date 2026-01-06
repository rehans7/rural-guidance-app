import 'package:flutter/material.dart';
import 'gemini_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, String>> _messages = [
    {
      "role": "bot",
      "text":
          "Hello 👋 I’m here to guide you.\nAsk me anything about careers or life skills.",
    },
  ];
  final GeminiService _geminiService = GeminiService();
  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": text});
    });

    _controller.clear();

    final reply = await _geminiService.sendMessage(text);

    setState(() {
      _messages.add({"role": "bot", "text": reply});
    });
  }

  void _sendFromChip(String text) async {
    setState(() {
      _messages.add({"role": "user", "text": text});
    });

    final reply = await GeminiService().sendMessage(text);

    setState(() {
      _messages.add({"role": "bot", "text": reply});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Career Guidance",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: msg["role"] == "user"
                      ? _userBubble(msg["text"]!)
                      : _botBubble(msg["text"]!),
                );
              },
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _suggestionChip(
                  "Career guidance",
                  () => _sendFromChip("Career guidance"),
                ),
                _suggestionChip(
                  "I am confused",
                  () => _sendFromChip("I am confused"),
                ),
                _suggestionChip(
                  "What should I study?",
                  () => _sendFromChip("What should I study?"),
                ),
                _suggestionChip(
                  "Job after college",
                  () => _sendFromChip("Job after college"),
                ),
              ],
            ),
          ),
          // INPUT
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      filled: true,
                      fillColor: const Color(0xFFF1F5F9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _botBubble(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.all(14),
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  );
}

Widget _userBubble(String text) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      padding: const EdgeInsets.all(14),
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  );
}

Widget _suggestionChip(String text, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: ActionChip(
      label: Text(text, style: const TextStyle(color: Colors.white)),
      backgroundColor: const Color(0xFF3B82F6),
      onPressed: onTap,
    ),
  );
}
