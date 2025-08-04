import 'package:flutter/material.dart';
import 'package:orballe/Home/homePage.dart';
import 'package:orballe/analytics/components/analytics.dart';
import 'package:orballe/brandDeals/brand_deals_page.dart';
import 'package:orballe/payment/payment_page.dart';
// import 'package:orballe/analytics/analytics_page.dart';
import 'package:orballe/contentPlanner/content_planner.dart';
import 'package:orballe/variables/userProfile.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  Future<Map<String, dynamic>> fetchAnalyticsData() async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'overview': [
        {'title': 'Total Views', 'value': '12,345', 'change': '+12%'},
        {'title': 'Total Likes', 'value': '6,789', 'change': '+8%'},
        {'title': 'Total Shares', 'value': '3,456', 'change': '+5%'},
      ],
      'charts': [
        {'type': 'line', 'title': 'Views Over Time', 'value': '12,345', 'change': '+12%'},
        {'type': 'bar', 'title': 'Likes Per Post', 'value': '6,789', 'change': '+8%'},
        {'type': 'line', 'title': 'Follower Growth', 'value': '1,234', 'change': '+15%'},
      ],
      'audience': {
        'title': 'Top Countries',
        'value': '5,678',
        'change': '+10%',
        'countries': ['USA', 'Canada', 'UK', 'Australia', 'Germany'],
        'values': [0.9, 0.8, 0.6, 0.4, 0.3],
      }
    };
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ContentPlannerPage()));
        break;
      case 2:
        // Already on Analytics
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BrandDealsPage()));
        break;
      case 4:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PaymentsPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/logo.png", height: 120, fit: BoxFit.contain),
                  SizedBox(
                    height: 48,
                    width: 48,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userProfile["profilePhoto"].toString()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: 2,
            onDestinationSelected: (index) => _handleNavigation(context, index),
            backgroundColor: Colors.white,
            labelType: NavigationRailLabelType.all,
            selectedIconTheme: const IconThemeData(color: Color(0xFF1A73E8)),
            selectedLabelTextStyle: const TextStyle(color: Color(0xFF1A73E8)),
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Dashboard')),
              NavigationRailDestination(icon: Icon(Icons.calendar_today), label: Text('Content Planner')),
              NavigationRailDestination(icon: Icon(Icons.bar_chart), label: Text('Analytics')),
              NavigationRailDestination(icon: Icon(Icons.handshake), label: Text('Brand Deals')),
              NavigationRailDestination(icon: Icon(Icons.payments), label: Text('Payments')),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: FutureBuilder<Map<String, dynamic>>(
                future: fetchAnalyticsData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final overview = snapshot.data!['overview'] as List;
                  final charts = snapshot.data!['charts'] as List;
                  final audience = snapshot.data!['audience'] as Map<String, dynamic>;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Analytics', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text('Track your performance and understand your audience'),
                        const SizedBox(height: 24),
                        const Text('Overview', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: overview.map<Widget>((item) => Expanded(
                            child: MetricCard(
                              title: item['title'],
                              value: item['value'],
                              change: item['change'],
                            ),
                          )).toList(),
                        ),
                        const SizedBox(height: 32),
                        const Text('Engagement', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Row(
                          children: charts.sublist(0, 2).map<Widget>((chart) {
                            return Expanded(
                              child: chart['type'] == 'line'
                                  ? LineChartCard(title: chart['title'], value: chart['value'], change: chart['change'])
                                  : BarChartCard(title: chart['title'], value: chart['value'], change: chart['change']),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 32),
                        const Text('Growth', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: LineChartCard(
                                title: charts[2]['title'],
                                value: charts[2]['value'],
                                change: charts[2]['change'],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AudienceCard(
                                title: audience['title'],
                                value: audience['value'],
                                change: audience['change'],
                                countries: List<String>.from(audience['countries']),
                                values: List<double>.from(audience['values']),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
