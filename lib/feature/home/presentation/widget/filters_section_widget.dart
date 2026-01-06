import 'package:bexel/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../core/Enums/app_enums.dart';
import '../../../../Core/Themes/app_colors.dart';
import 'filter_chip_widget.dart';

class FiltersSectionWidget extends StatelessWidget {
  final HomeCubit cubit;

  const FiltersSectionWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reset Filters Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              TextButton.icon(
                onPressed: () => cubit.resetFilters(),
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Reset'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary500,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 16),
          // Sort Order
          Text(
            'Sort by Date',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              FilterChipWidget(
                label: 'Newest First',
                isSelected: cubit.sortOrder == SortOrder.descending,
                onTap: () => cubit.setSortOrder(SortOrder.descending),
              ),
              const SizedBox(width: 8),
              FilterChipWidget(
                label: 'Oldest First',
                isSelected: cubit.sortOrder == SortOrder.ascending,
                onTap: () => cubit.setSortOrder(SortOrder.ascending),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Status Filter
          Text(
            'Status',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              FilterChipWidget(
                label: 'All',
                isSelected: cubit.statusFilter == TaskStatusFilter.all,
                onTap: () => cubit.setStatusFilter(TaskStatusFilter.all),
              ),
              const SizedBox(width: 8),
              FilterChipWidget(
                label: 'Completed',
                isSelected: cubit.statusFilter == TaskStatusFilter.completed,
                onTap: () => cubit.setStatusFilter(TaskStatusFilter.completed),
              ),
              const SizedBox(width: 8),
              FilterChipWidget(
                label: 'Incomplete',
                isSelected: cubit.statusFilter == TaskStatusFilter.incomplete,
                onTap: () => cubit.setStatusFilter(TaskStatusFilter.incomplete),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Type Filter
          Text(
            'Type',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              FilterChipWidget(
                label: 'All',
                isSelected: cubit.typeFilter == TaskTypeFilter.all,
                onTap: () => cubit.setTypeFilter(TaskTypeFilter.all),
              ),
              const SizedBox(width: 8),
              FilterChipWidget(
                label: 'Personal',
                isSelected: cubit.typeFilter == TaskTypeFilter.personal,
                onTap: () => cubit.setTypeFilter(TaskTypeFilter.personal),
              ),
              const SizedBox(width: 8),
              FilterChipWidget(
                label: 'Work',
                isSelected: cubit.typeFilter == TaskTypeFilter.work,
                onTap: () => cubit.setTypeFilter(TaskTypeFilter.work),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
