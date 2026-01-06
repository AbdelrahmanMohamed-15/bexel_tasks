part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

// Success State
final class HomeSuccess extends HomeState {
  final List<Task> tasks;
  final List<Task> displayedTasks;
  final bool showFilters;
  final bool isLoadingMore;
  final bool hasMore;
  const HomeSuccess({
    required this.tasks,
    required this.displayedTasks,
    this.showFilters = false,
    this.isLoadingMore = false,
    this.hasMore = false,
  });
  @override
  List<Object> get props => [tasks, displayedTasks, showFilters, isLoadingMore, hasMore];
}

// Error State
final class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});
  @override
  List<Object> get props => [message];
}
