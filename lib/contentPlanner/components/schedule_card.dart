import 'package:flutter/material.dart';

class ContentScheduleCard extends StatelessWidget {
  final String title;
  final String category;
  final String status;
  final List<String> platforms;
  final String thumbnailUrl;
  final String action;

  const ContentScheduleCard({
    super.key,
    required this.title,
    required this.category,
    required this.status,
    required this.platforms,
    required this.thumbnailUrl,
    required this.action,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case 'Draft':
        return const Color(0xFFFACC15);
      case 'Scheduled':
        return const Color(0xFF60A5FA);
      case 'Posted':
        return const Color(0xFF4ADE80);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(thumbnailUrl), radius: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: getStatusColor(status).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(status, style: TextStyle(color: getStatusColor(status), fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 12),
                      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(category, style: const TextStyle(color: Color(0xFF64748B))),
                  const SizedBox(height: 8),
                  Row(
                    children: platforms.map((platform) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            platform == 'IG' ? Icons.camera_alt : platform == 'YT' ? Icons.ondemand_video : Icons.tiktok,
                            size: 16,
                            color: const Color(0xFF1A73E8),
                          ),
                          const SizedBox(width: 4),
                          Text(platform, style: const TextStyle(fontSize: 12))
                        ],
                      ),
                    )).toList(),
                  )
                ],
              ),
            ),
            TextButton(onPressed: () {}, child: Text(action))
          ],
        ),
      ),
    );
  }
}
