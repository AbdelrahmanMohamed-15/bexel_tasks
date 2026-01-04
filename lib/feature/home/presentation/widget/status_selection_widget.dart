import 'package:flutter/material.dart';

class StatusSelectionWidget extends StatelessWidget {
  final String selectedStatus;
  final Function(String) onStatusSelected;

  const StatusSelectionWidget({
    super.key,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatusChip(
            status: 'Complete',
            color: Colors.green,
            isSelected: selectedStatus == 'Complete',
            onTap: () => onStatusSelected('Complete'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatusChip(
            status: 'Incomplete',
            color: Colors.orange,
            isSelected: selectedStatus == 'Incomplete',
            onTap: () => onStatusSelected('Incomplete'),
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _StatusChip({
    required this.status,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              status,
              style: TextStyle(
                color: isSelected ? color : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

