import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;

  const OverviewCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, color: Color(0xFF64748B))),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 4),
            Text(change, style: const TextStyle(fontSize: 14, color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
