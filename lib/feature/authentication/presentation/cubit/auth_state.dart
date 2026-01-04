part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

// state for password visibility toggle
final class PasswordVisibilityState extends AuthState {
  final bool isPasswordVisible;
  const PasswordVisibilityState({required this.isPasswordVisible});

  @override
  List<Object> get props => [isPasswordVisible];
}
