import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;

  const MetricCard({super.key, required this.title, required this.value, required this.change});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, color: Color(0xFF64748B))),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 4),
            Text(change, style: const TextStyle(color: Colors.green, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class LineChartCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;

  const LineChartCard({super.key, required this.title, required this.value, required this.change});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(change, style: const TextStyle(color: Colors.green))
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Last 30 Days'),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1), FlSpot(1, 2), FlSpot(2, 1.5), FlSpot(3, 3),
                        FlSpot(4, 2), FlSpot(5, 2.5), FlSpot(6, 3),
                      ],
                      isCurved: true,
                      barWidth: 2,
                      // colors: [const Color(0xFF1A73E8)],
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

class BarChartCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;

  const BarChartCard({super.key, required this.title, required this.value, required this.change});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(change, style: const TextStyle(color: Colors.green))
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Last 7 Posts'),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: BarChart(
                BarChartData(
                  barGroups: [1.0, 1.5, 0.8, 1.2, 1.0, 1.8, 1.2].asMap().entries.map((entry) {
                    return BarChartGroupData(x: entry.key, barRods: [
                      BarChartRodData(toY: entry.value, color: const Color(0xFF1A73E8), width: 12)
                    ]);
                  }).toList(),
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

class AudienceCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final List<String> countries;
  final List<double> values;

  const AudienceCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.countries,
    required this.values,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(change, style: const TextStyle(color: Colors.green)),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Last 30 Days'),
            const SizedBox(height: 12),
            ...List.generate(countries.length, (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(countries[index]),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: values[index],
                    backgroundColor: const Color(0xFFE0E7FF),
                    color: const Color(0xFF1A73E8),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(8),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
