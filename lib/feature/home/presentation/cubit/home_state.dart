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
  final bool showFilters;
  const HomeSuccess({
    required this.tasks,
    this.showFilters = false,
  });
  @override
  List<Object> get props => [tasks, showFilters];
}

// Error State
final class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});
  @override
  List<Object> get props => [message];
}
