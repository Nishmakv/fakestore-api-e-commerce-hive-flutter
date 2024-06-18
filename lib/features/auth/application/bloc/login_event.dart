part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
  List<Object?> get props => [];
}

class UserLogin extends LoginEvent {
  final String username;
  final String password;
  const UserLogin({
    required this.username,
    required this.password,
  });
}
