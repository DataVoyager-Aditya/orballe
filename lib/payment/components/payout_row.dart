import 'package:flutter/material.dart';

class PayoutRow extends StatelessWidget {
  final String date;
  final String amount;
  final String status;

  const PayoutRow({
    super.key,
    required this.date,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(date)),
          Expanded(flex: 2, child: Text(amount)),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(status, style: const TextStyle(color: Colors.green)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFDCE9FF),
                ),
                child: const Text('Download'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
