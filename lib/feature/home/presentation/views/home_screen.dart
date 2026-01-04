import 'package:bexel/Core/Themes/app_colors.dart';
import 'package:bexel/Core/Constant/base_constant.dart';
import 'package:bexel/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bexel/Core/Routes/app_navigation.dart';
import 'package:bexel/Core/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/task_card.dart';
import '../widget/search_bar_widget.dart';
import '../widget/filters_section_widget.dart';
import '../widget/empty_tasks_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary500,
            leading: const SizedBox(),
            centerTitle: true,
            title: Text(
              'Bexel Tasks',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontFamily: BaseConstant.cairoBold,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  homeCubit.showFilters
                      ? Icons.filter_list
                      : Icons.filter_list_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  homeCubit.toggleFilters();
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Search Bar
              SearchBarWidget(
                controller: homeCubit.searchController,
                onSearch: (query) => homeCubit.searchTasks(query),
              ),

              // Filters Section
              if (homeCubit.showFilters) FiltersSectionWidget(cubit: homeCubit),

              // Tasks List
              Expanded(
                child: homeCubit.tasks.isEmpty
                    ? const EmptyTasksWidget()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: homeCubit.tasks.length,
                        itemBuilder: (context, index) {
                          var task = homeCubit.tasks[index];
                          return GestureDetector(
                            onTap: () {
                              AppNavigation.pushNamed(
                                AppRoutes.taskDetails,
                                arguments: task,
                              );
                            },
                            child: TaskCard(task: task),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AppNavigation.pushNamed('/addTask');
            },
            backgroundColor: AppColors.primary500,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }
}
