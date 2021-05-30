part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommentations extends HomeEvent {
  List<Object> get props => [];
}

class FetchMoreRecommentations extends HomeEvent {
  List<Object> get props => [];
}
