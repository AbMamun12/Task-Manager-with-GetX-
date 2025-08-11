import 'package:flutter/material.dart';

class TaskStatusSummaryCount extends StatelessWidget {
  const TaskStatusSummaryCount({
    super.key,
    required this.count,
    required this.title,
    this.backgroundColor,
  });

  final String count;
  final String title;
  final Color? backgroundColor;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.lightBlueAccent;
      case 'completed':
        return Colors.green;
      case 'progress':
        return Colors.purpleAccent;
      case 'cancelled':
        return Colors.redAccent;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bgColor = backgroundColor ?? _getStatusColor(title);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      color: bgColor,
      elevation: 1,
      shadowColor: Colors.black38,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            Text(
              title,
              style: textTheme.titleSmall?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
