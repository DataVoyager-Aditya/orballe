import 'package:flutter/material.dart';
class BrandDealCard extends StatelessWidget {
  final String brandImage;
  final String dealName;
  final String payout;
  final String status;
  final VoidCallback onTap;
  final bool showApplyButton;

  const BrandDealCard({
    super.key,
    required this.brandImage,
    required this.dealName,
    required this.payout,
    required this.status,
    required this.onTap,
    this.showApplyButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          // Brand + Deal Name
          Expanded(
            flex: 4,
            child: Row(
              children: [
                CircleAvatar(radius: 20, backgroundImage: AssetImage(brandImage)),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(dealName, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),

          // Payout
          Expanded(
            flex: 2,
            child: Text(
              payout,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          // Status
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: status == 'Available' ? Colors.green[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: status == 'Available' ? Colors.green : Colors.grey[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Button
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: showApplyButton
                  ? TextButton(
                      onPressed: onTap,
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF1A73E8),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Apply"),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
