part of 'user_bloc.dart';

abstract class UserEvent {
  const UserEvent();
}

class PerfomLogin extends UserEvent {
  final String email;
  final String password;

  const PerfomLogin({
    @required this.email,
    @required this.password,
  });

  List<Object> get props => [email, password];
}

class LogOut extends UserEvent {
  List<Object> get props => throw UnimplementedError();
}

class InitLogin extends UserEvent {
  List<Object> get props => [];
}

class FetchUserDetails extends UserEvent {
  List<Object> get props => throw UnimplementedError();
}
