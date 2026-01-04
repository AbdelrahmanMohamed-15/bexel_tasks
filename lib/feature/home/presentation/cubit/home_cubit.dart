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

  String _searchQuery = '';
  SortOrder _sortOrder = SortOrder.ascending;
  TaskStatusFilter _statusFilter = TaskStatusFilter.all;
  TaskTypeFilter _typeFilter = TaskTypeFilter.all;
  bool _showFilters = false;

  // Controllers
  final TextEditingController searchController = TextEditingController();

  List<Task> get tasks => _filteredTasks;
  String get searchQuery => _searchQuery;
  SortOrder get sortOrder => _sortOrder;
  TaskStatusFilter get statusFilter => _statusFilter;
  TaskTypeFilter get typeFilter => _typeFilter;
  bool get showFilters => _showFilters;

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
    _applyFilters();
  }

  void setSortOrder(SortOrder order) {
    _sortOrder = order;
    _applyFilters();
  }

  void setStatusFilter(TaskStatusFilter filter) {
    _statusFilter = filter;
    _applyFilters();
  }

  void setTypeFilter(TaskTypeFilter filter) {
    _typeFilter = filter;
    _applyFilters();
  }

  void toggleFilters() {
    _showFilters = !_showFilters;
    emit(HomeSuccess(tasks: _filteredTasks));
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

    emit(HomeSuccess(tasks: _filteredTasks));
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
