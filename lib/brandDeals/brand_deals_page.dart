// brand_deals_page.dart
import 'package:flutter/material.dart';
import 'package:orballe/Home/homePage.dart';
import 'package:orballe/analytics/analytics_page.dart';
import 'package:orballe/brandDeals/components/brand_deal_card.dart';
import 'package:orballe/brandDeals/components/chatbox.dart';
import 'package:orballe/contentPlanner/content_planner.dart';
import 'package:orballe/payment/payment_page.dart';
import 'package:orballe/variables/userProfile.dart';

class BrandDealsPage extends StatefulWidget {
  const BrandDealsPage({super.key});

  @override
  State<BrandDealsPage> createState() => _BrandDealsPageState();
}

class _BrandDealsPageState extends State<BrandDealsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> messages = [
    {'text': "Hey! We saw your application and we'd love to move forward.", 'isSender': false},
    {'text': "That's great news! What are the next steps?", 'isSender': true},
  ];

  final List<Map<String, dynamic>> availableDeals = [
    {'brandImage': 'assets/images/brand1.png', 'dealName': 'Tech Review', 'payout': '\$500', 'status': 'Available'},
    {'brandImage': 'assets/images/brand2.png', 'dealName': 'Summer Fashion Lookbook', 'payout': '\$750', 'status': 'Available'},
    {'brandImage': 'assets/images/brand3.png', 'dealName': 'Food Review', 'payout': '\$300', 'status': 'Closed'},
    {'brandImage': 'assets/images/brand4.png', 'dealName': 'Makeup Tutorial', 'payout': '\$600', 'status': 'Closed'},
    {'brandImage': 'assets/images/brand5.png', 'dealName': 'Workout Routine', 'payout': '\$400', 'status': 'Closed'},
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  void _handleSend(String message) {
    setState(() {
      messages.add({'text': message, 'isSender': true});
    });
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AnalyticsPage()));
        break;
      case 3:
        // Already on Brand Deals
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
            selectedIndex: 3,
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Brand Deals Marketplace', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TabBar(
                    controller: _tabController,
                    labelColor: const Color(0xFF1A73E8),
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: 'Available'),
                      Tab(text: 'Applied'),
                      Tab(text: 'Completed'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDealList(availableDeals),
                        const Center(child: Text('You have not applied to any deals yet.')),
                        const Center(child: Text('No deals completed yet.')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: ChatBox(messages: messages, onSend: _handleSend),
          ),
        ],
      ),
    );
  }

  Widget _buildDealList(List<Map<String, dynamic>> deals) {
    return ListView.builder(
      itemCount: deals.length,
      itemBuilder: (context, index) {
        final deal = deals[index];
        return BrandDealCard(
          brandImage: deal['brandImage'],
          dealName: deal['dealName'],
          payout: deal['payout'],
          status: deal['status'],
          onTap: () {},
        );
      },
    );
  }
}
