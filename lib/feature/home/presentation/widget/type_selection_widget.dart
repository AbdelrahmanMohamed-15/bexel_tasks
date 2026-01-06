import 'package:bexel/Core/Themes/app_colors.dart';
import 'package:flutter/material.dart';

class TypeSelectionWidget extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const TypeSelectionWidget({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TypeChip(
            type: 'Personal',
            icon: Icons.person_outline,
            isSelected: selectedType == 'Personal',
            onTap: () => onTypeSelected('Personal'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TypeChip(
            type: 'Work',
            icon: Icons.work_outline,
            isSelected: selectedType == 'Work',
            onTap: () => onTypeSelected('Work'),
          ),
        ),
      ],
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String type;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeChip({
    required this.type,
    required this.icon,
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
          color: isSelected
              ? AppColors.primary500.withOpacity(0.1)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary500 : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary500 : Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              type,
              style: TextStyle(
                color: isSelected ? AppColors.primary500 : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


