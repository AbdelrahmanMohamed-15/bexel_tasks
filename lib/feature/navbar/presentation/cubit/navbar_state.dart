part of 'navbar_cubit.dart';

sealed class NavbarState extends Equatable {
  const NavbarState();

  @override
  List<Object> get props => [];
}

final class NavbarInitial extends NavbarState {}

// state for changing navbar index
final class ChangeNavbarState extends NavbarState {
  final int index;

  const ChangeNavbarState({required this.index});

  @override
  List<Object> get props => [index];
}
