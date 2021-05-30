part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class Loading extends HomeState {}

class DataLoaded extends HomeState {
  final data;
  String cursor;
  final bool hasReachedMax;
  DataLoaded({this.data, this.hasReachedMax, this.cursor});
  DataLoaded copyWith({var data, var hasReachedMax, var cursor}) {
    return DataLoaded(
        data: data ?? this.data,
        cursor: data ?? this.cursor,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [data, hasReachedMax];
}

class ErrorReceived extends HomeState {
  final err;
  ErrorReceived({this.err});
  ErrorReceived copyWith({var err}) {
    return ErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object> get props => [err];
}
