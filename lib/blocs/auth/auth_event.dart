part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {
  get context => null;
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoginRequested(this.email, this.password, this.context);

  @override
  List<Object?> get props => [email, password, context];

}

class LogoutRequested extends AuthEvent {}
