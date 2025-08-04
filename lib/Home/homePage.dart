import 'package:flutter/material.dart';
import 'package:orballe/contentPlanner/content_planner.dart';
import 'package:orballe/analytics/analytics_page.dart';
import 'package:orballe/brandDeals/brand_deals_page.dart';
import 'package:orballe/payment/payment_page.dart'; 
import 'package:orballe/variables/userProfile.dart';
import 'components/overview_card.dart';
import 'components/recent_activity_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> overviewData = const [
    {'title': 'Total Revenue', 'value': '\$12,345', 'change': '+10%'},
    {'title': 'Total Views', 'value': '678,901', 'change': '+5%'},
    {'title': 'Total Subscribers', 'value': '12,345', 'change': '+2%'},
  ];

  final List<Map<String, String>> activityData = const [
    {'icon': 'money', 'text': 'Received payment of \$500 from Brand X', 'time': '2 days ago'},
    {'icon': 'video', 'text': 'Published new video: "My Favorite Recipes"', 'time': '1 week ago'},
    {'icon': 'person', 'text': 'Reached 10,000 subscribers', 'time': '2 weeks ago'},
    {'icon': 'person', 'text': 'Reached 1,000 subscribers', 'time': '22 weeks ago'},
  ];

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Already on HomePage (Dashboard), do nothing
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ContentPlannerPage()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AnalyticsPage()));
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
                  Image.asset(
                    "assets/images/logo.png",
                    height: 120,
                    fit: BoxFit.contain,
                  ),
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
            selectedIndex: 0,
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Dashboard', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: overviewData
                          .map((data) => OverviewCard(
                                title: data['title'],
                                value: data['value'],
                                change: data['change'],
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 32),
                    const Text('Recent Activity', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: activityData.length,
                        itemBuilder: (context, index) => RecentActivityTile(
                          iconType: activityData[index]['icon']!,
                          text: activityData[index]['text']!,
                          time: activityData[index]['time']!,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Quick Actions', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A73E8),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {},
                          child: const Text('Create Content', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {},
                          child: const Text('Schedule Post'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
