import 'package:flutter/material.dart';

class TaskCreatedDateWidget extends StatelessWidget {
  final DateTime createdAt;

  const TaskCreatedDateWidget({
    super.key,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Text(
            'Created: ${createdAt.toString().substring(0, 16)}',
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}


