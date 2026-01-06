import 'package:bexel/Core/Data/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:async';

import '../../../../core/Enums/app_enums.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    _initializeStream();
    _initializeSearchController();
  }

  void _initializeSearchController() {
    searchController.addListener(() {
      searchTasks(searchController.text);
    });
  }

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  final AppDatabase _appDatabase = GetIt.instance<AppDatabase>();
  StreamSubscription<List<Task>>? _tasksSubscription;

  List<Task> _allTasks = [];
  List<Task> _filteredTasks = [];
  List<Task> _displayedTasks = [];

  static const int _pageSize = 15;
  int _currentPage = 1;

  String _searchQuery = '';
  SortOrder _sortOrder = SortOrder.ascending;
  TaskStatusFilter _statusFilter = TaskStatusFilter.all;
  TaskTypeFilter _typeFilter = TaskTypeFilter.all;
  bool _showFilters = false;

  // Controllers
  final TextEditingController searchController = TextEditingController();

  List<Task> get tasks => _displayedTasks;
  List<Task> get allFilteredTasks => _filteredTasks;
  String get searchQuery => _searchQuery;
  SortOrder get sortOrder => _sortOrder;
  TaskStatusFilter get statusFilter => _statusFilter;
  TaskTypeFilter get typeFilter => _typeFilter;
  bool get showFilters => _showFilters;
  bool get hasMore => _displayedTasks.length < _filteredTasks.length;

  void _initializeStream() {
    _tasksSubscription?.cancel();
    _tasksSubscription = _appDatabase.watchAllTasks().listen(
      (tasks) {
        _allTasks = tasks;
        _applyFilters();
      },
      onError: (error) {
        emit(HomeError(message: error.toString()));
      },
    );
  }

  void searchTasks(String query) {
    _searchQuery = query.toLowerCase();
    _currentPage = 1; // Reset pagination on search
    _applyFilters();
  }

  void setSortOrder(SortOrder order) {
    _sortOrder = order;
    _currentPage = 1; // Reset pagination on sort change
    _applyFilters();
  }

  void setStatusFilter(TaskStatusFilter filter) {
    _statusFilter = filter;
    _currentPage = 1; // Reset pagination on filter change
    _applyFilters();
  }

  void setTypeFilter(TaskTypeFilter filter) {
    _typeFilter = filter;
    _currentPage = 1; // Reset pagination on filter change
    _applyFilters();
  }

  void toggleFilters() {
    _showFilters = !_showFilters;
    _updateDisplayedTasks();
  }

  void resetFilters() {
    _searchQuery = '';
    _sortOrder = SortOrder.ascending;
    _statusFilter = TaskStatusFilter.all;
    _typeFilter = TaskTypeFilter.all;
    _currentPage = 1;
    searchController.clear();
    _applyFilters();
  }

  void loadMoreTasks() {
    // Check if there are more items to load
    final currentDisplayedCount = _displayedTasks.length;
    final totalFilteredCount = _filteredTasks.length;

    if (currentDisplayedCount >= totalFilteredCount || _isLoadingMore) {
      return;
    }

    _isLoadingMore = true;
    emit(
      HomeSuccess(
        tasks: _filteredTasks,
        displayedTasks: _displayedTasks,
        showFilters: _showFilters,
        isLoadingMore: true,
        hasMore: currentDisplayedCount < totalFilteredCount,
      ),
    );

    // Simulate loading delay for better UX
    Future.delayed(const Duration(milliseconds: 300), () {
      _currentPage++;
      _updateDisplayedTasks();
    });
  }

  bool _isLoadingMore = false;

  void _updateDisplayedTasks({bool forceUpdate = false}) {
    if (_filteredTasks.isEmpty) {
      _displayedTasks = [];
    } else {
      final endIndex = (_currentPage * _pageSize).clamp(
        0,
        _filteredTasks.length,
      );
      // Always update if endIndex is different OR if forceUpdate is true (e.g., when filters change)
      if (endIndex != _displayedTasks.length || forceUpdate) {
        _displayedTasks = _filteredTasks.sublist(0, endIndex);
      }
    }

    // Calculate hasMore after updating displayed tasks
    final hasMoreItems = _displayedTasks.length < _filteredTasks.length;
    _isLoadingMore = false;

    emit(
      HomeSuccess(
        tasks: _filteredTasks,
        displayedTasks: _displayedTasks,
        showFilters: _showFilters,
        isLoadingMore: false,
        hasMore: hasMoreItems,
      ),
    );
  }

  void _applyFilters() {
    _filteredTasks = List<Task>.from(_allTasks);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      _filteredTasks = _filteredTasks.where((task) {
        final title = task.title.toLowerCase();
        final description = (task.description ?? '').toLowerCase();
        final type = (task.type ?? '').toLowerCase();
        return title.contains(_searchQuery) ||
            description.contains(_searchQuery) ||
            type.contains(_searchQuery);
      }).toList();
    }

    // Apply status filter
    if (_statusFilter != TaskStatusFilter.all) {
      _filteredTasks = _filteredTasks.where((task) {
        if (_statusFilter == TaskStatusFilter.completed) {
          return task.isCompleted == 'Complete';
        } else {
          return task.isCompleted != 'Complete';
        }
      }).toList();
    }

    // Apply type filter
    if (_typeFilter != TaskTypeFilter.all) {
      _filteredTasks = _filteredTasks.where((task) {
        if (_typeFilter == TaskTypeFilter.personal) {
          return task.type == 'Personal';
        } else {
          return task.type == 'Work';
        }
      }).toList();
    }

    // Apply sort
    _filteredTasks.sort((a, b) {
      if (_sortOrder == SortOrder.ascending) {
        return a.createdAt.compareTo(b.createdAt);
      } else {
        return b.createdAt.compareTo(a.createdAt);
      }
    });

    // Force update when filters are applied to ensure UI reflects the new filtered list
    _updateDisplayedTasks(forceUpdate: true);
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _appDatabase.deleteTask(task);
    } catch (e) {
      emit(HomeError(message: 'Failed to delete task: ${e.toString()}'));
    }
  }

  Future<void> addTask({
    required String title,
    String? description,
    required String type,
    required String isCompleted,
  }) async {
    try {
      await _appDatabase.insertTask(
        TasksCompanion(
          title: drift.Value(title),
          description: description != null && description.isNotEmpty
              ? drift.Value(description)
              : const drift.Value.absent(),
          type: drift.Value(type),
          isCompleted: drift.Value(isCompleted),
          createdAt: drift.Value(DateTime.now()),
        ),
      );
    } catch (e) {
      emit(HomeError(message: 'Failed to add task: ${e.toString()}'));
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _appDatabase.updateTask(task);
    } catch (e) {
      emit(HomeError(message: 'Failed to update task: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _tasksSubscription?.cancel();
    searchController.dispose();
    return super.close();
  }
}
