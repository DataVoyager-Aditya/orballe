// chat_box.dart
import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  final List<Map<String, dynamic>> messages;
  final void Function(String message) onSend;

  const ChatBox({super.key, required this.messages, required this.onSend});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    if (_controller.text.trim().isEmpty) return;
    widget.onSend(_controller.text.trim());
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: widget.messages.length,
            itemBuilder: (context, index) {
              final message = widget.messages[index];
              final isSender = message['isSender'] ?? false;

              return Align(
                alignment:
                    isSender ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSender ? const Color(0xFF1A73E8) : const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    message['text'],
                    style: TextStyle(
                      color: isSender ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _handleSend,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A73E8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text('Send'),
              )
            ],
          ),
        )
      ],
    );
  }
}
