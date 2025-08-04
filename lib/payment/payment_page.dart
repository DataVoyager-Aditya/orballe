import 'package:flutter/material.dart';
import 'package:orballe/Home/homepage.dart';
import 'package:orballe/contentPlanner/content_planner.dart';
import 'package:orballe/analytics/analytics_page.dart';
import 'package:orballe/brandDeals/brand_deals_page.dart';
import 'package:orballe/payment/components/line_chart.dart';
import 'package:orballe/payment/components/payout_row.dart';
import 'package:orballe/variables/userProfile.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  final List<Map<String, dynamic>> payoutHistory = const [
    {'date': 'July 15, 2024', 'amount': '\$500.00', 'status': 'Paid'},
    {'date': 'June 15, 2024', 'amount': '\$450.00', 'status': 'Paid'},
    {'date': 'May 15, 2024', 'amount': '\$284.56', 'status': 'Paid'},
  ];

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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BrandDealsPage()));
        break;
      case 4:
        // Already on PaymentsPage
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
            selectedIndex: 4,
            onDestinationSelected: (int index) => _handleNavigation(context, index),
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
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Payments & Earnings', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Manage your earnings and payouts'),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A73E8),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('New Payout'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: LineChartCard(
                          title: 'Earnings',
                          amount: '\$1,234.56',
                          change: '+12% vs last 30 days',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: _buildBankCard(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text('Payout History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildPayoutTable(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBankCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bank Connection', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    Icon(Icons.account_balance, color: Color(0xFF1A73E8)),
                    SizedBox(width: 8),
                    Text('Bank of America'),
                  ],
                ),
                Text('Manage', style: TextStyle(color: Color(0xFF1A73E8))),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 10),
                SizedBox(width: 6),
                Text('Connected', style: TextStyle(fontSize: 12)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPayoutTable() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(flex: 3, child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Invoice', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(height: 8),
            ...payoutHistory.map((payout) => PayoutRow(
                  date: payout['date'],
                  amount: payout['amount'],
                  status: payout['status'],
                ))
          ],
        ),
      ),
    );
  }
}
