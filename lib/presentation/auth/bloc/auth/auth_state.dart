abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthInvalidState extends AuthState {}

class AuthValidState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;
  AuthErrorState({required this.errorMessage});
}

class AuthLoadingState extends AuthState {}
