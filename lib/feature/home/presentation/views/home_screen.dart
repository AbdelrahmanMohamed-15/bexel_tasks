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
        final showFilters = state is HomeSuccess
            ? state.showFilters
            : homeCubit.showFilters;
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
                  showFilters ? Icons.filter_list : Icons.filter_list_outlined,
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
              // Filters Section
              if (showFilters) FiltersSectionWidget(cubit: homeCubit),

              // Search Bar
              SearchBarWidget(
                controller: homeCubit.searchController,
                onSearch: (query) => homeCubit.searchTasks(query),
              ),

              // Tasks List
              Expanded(
                child: state is HomeSuccess && state.displayedTasks.isEmpty
                    ? const EmptyTasksWidget()
                    : NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo is ScrollUpdateNotification) {
                            final maxScroll =
                                scrollInfo.metrics.maxScrollExtent;
                            final currentScroll = scrollInfo.metrics.pixels;

                            // Only trigger if we're near the bottom and not already loading
                            if (state is HomeSuccess &&
                                state.hasMore &&
                                !state.isLoadingMore &&
                                maxScroll > 0) {
                              // Load more when user is 200px from bottom
                              final threshold = maxScroll - 200;

                              if (currentScroll >= threshold) {
                                homeCubit.loadMoreTasks();
                              }
                            }
                          }
                          return false;
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: state is HomeSuccess
                              ? state.displayedTasks.length +
                                    (state.hasMore ? 1 : 0)
                              : homeCubit.tasks.length,
                          itemBuilder: (context, index) {
                            if (state is HomeSuccess) {
                              // Show loading indicator at the bottom
                              if (index == state.displayedTasks.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              var task = state.displayedTasks[index];
                              return GestureDetector(
                                onTap: () {
                                  AppNavigation.pushNamed(
                                    AppRoutes.taskDetails,
                                    arguments: task,
                                  );
                                },
                                child: TaskCard(task: task),
                              );
                            }

                            // Fallback for other states
                            if (index >= homeCubit.tasks.length) {
                              return const SizedBox.shrink();
                            }
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
