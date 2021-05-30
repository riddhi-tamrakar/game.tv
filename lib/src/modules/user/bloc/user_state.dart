part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends UserState {
  @override
  List<Object> get props => [];
}

class LoggedOut extends UserState {
  @override
  List<Object> get props => [];
}

class LoginError extends UserState {
  @override
  List<Object> get props => [];
}

class Loading extends UserState {
  @override
  List<Object> get props => [];
}

class InvalidCredentials extends UserState {
  @override
  List<Object> get props => [];
}

class ErrorReceived extends UserState {
  final err;
  ErrorReceived({this.err});
  ErrorReceived copyWith({var err}) {
    return ErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object> get props => [err];
}

class UserDataLoaded extends UserState {
  final data;
  UserDataLoaded({this.data});
  UserDataLoaded copyWith({var data}) {
    return UserDataLoaded(data: data ?? this.data);
  }

  @override
  List<Object> get props => [data];
}
