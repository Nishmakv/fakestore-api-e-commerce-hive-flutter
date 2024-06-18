part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  fetching,
  fetched,
  exception,
}

class LoginState {
  final LoginStatus status;

  const LoginState({
    required this.status,
  });
  factory LoginState.initial() {
    return const LoginState(
      status: LoginStatus.initial,
    );
  }

  LoginState copyWith({
    required LoginStatus status,
  }) {
    return LoginState(
      status: status,
    );
  }
}
