import 'package:flutter/material.dart';
import 'package:orballe/Home/homePage.dart';
import 'package:orballe/analytics/analytics_page.dart';
import 'package:orballe/brandDeals/brand_deals_page.dart';
import 'package:orballe/payment/payment_page.dart';
import 'package:orballe/variables/userProfile.dart';
import 'components/schedule_card.dart';

class ContentPlannerPage extends StatelessWidget {
  const ContentPlannerPage({super.key});

  final List<Map<String, dynamic>> contentScheduleData = const [
    {
      'title': 'Summer Lookbook',
      'category': 'Fashion',
      'status': 'Draft',
      'platforms': ['IG', 'YT', 'TikTok'],
      'thumbnail': 'https://via.placeholder.com/48x48',
      'action': 'Edit'
    },
    {
      'title': 'Travel Vlog: Paris',
      'category': 'Travel',
      'status': 'Scheduled',
      'platforms': ['IG', 'YT', 'TikTok'],
      'thumbnail': 'https://via.placeholder.com/48x48',
      'action': 'Edit'
    },
    {
      'title': 'Morning Routine',
      'category': 'Lifestyle',
      'status': 'Posted',
      'platforms': ['IG', 'YT', 'TikTok'],
      'thumbnail': 'https://via.placeholder.com/48x48',
      'action': 'View'
    },
  ];

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        break;
      case 1:
        // Already on Content Planner, do nothing
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
            selectedIndex: 1,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Content Planner', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(Icons.chevron_left),
                                    Text('July 2024', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    Icon(Icons.chevron_right)
                                  ],
                                ),
                                const SizedBox(height: 12),
                                GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 7,
                                  children: List.generate(31, (index) {
                                    int day = index + 1;
                                    return Container(
                                      margin: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: day == 5 ? const Color(0xFF1A73E8) : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '$day',
                                        style: TextStyle(
                                          color: day == 5 ? Colors.white : const Color(0xFF0F172A),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Scheduled for July 5, 2024', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add, color: Colors.white),
                                  label: const Text('New Post', style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1A73E8),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: contentScheduleData.length,
                              itemBuilder: (context, index) => ContentScheduleCard(
                                title: contentScheduleData[index]['title'],
                                category: contentScheduleData[index]['category'],
                                status: contentScheduleData[index]['status'],
                                platforms: contentScheduleData[index]['platforms'],
                                thumbnailUrl: contentScheduleData[index]['thumbnail'],
                                action: contentScheduleData[index]['action'],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
