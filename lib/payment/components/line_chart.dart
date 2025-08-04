import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartCard extends StatelessWidget {
  final String title;
  final String amount;
  final String change;

  const LineChartCard({
    super.key,
    required this.title,
    required this.amount,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(amount, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Text(change, style: const TextStyle(color: Colors.green))
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 1.5), FlSpot(1, 1.3), FlSpot(2, 1.7),
                        FlSpot(3, 1.2), FlSpot(4, 2.2), FlSpot(5, 1.4),
                        FlSpot(6, 2.1),
                      ],
                      isCurved: true,
                      color: const Color(0xFF1A73E8),
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}