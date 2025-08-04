import 'package:flutter/material.dart';

class RecentActivityTile extends StatelessWidget {
  final String iconType;
  final String text;
  final String time;

  const RecentActivityTile({
    super.key,
    required this.iconType,
    required this.text,
    required this.time,
  });

  IconData getIcon(String type) {
    switch (type) {
      case 'money':
        return Icons.attach_money;
      case 'video':
        return Icons.ondemand_video;
      case 'person':
        return Icons.person;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE0F2FE),
        child: Icon(getIcon(iconType), color: const Color(0xFF1A73E8)),
      ),
      title: Text(text, style: const TextStyle(color: Color(0xFF0F172A))),
      trailing: Text(time, style: const TextStyle(color: Color(0xFF94A3B8))),
    );
  }
}
