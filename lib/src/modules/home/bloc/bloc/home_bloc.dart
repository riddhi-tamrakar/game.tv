import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:app/src/modules/home/models/tournament.dart';
import 'package:app/src/modules/home/models/tournament_response.dart';
import 'package:app/src/services/db_service.dart';
import 'package:app/src/services/db_service_response.model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());
  final DbServices _dbServices = DbServices();
  int count = 10;

  @override
  Stream<Transition<HomeEvent, HomeState>> transformEvents(
    Stream<HomeEvent> events,
    TransitionFunction<HomeEvent, HomeState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    final currentState = state;

    if (event is FetchRecommentations) {
      try {
        yield Loading();
        TournamentResponse _data = await _fetchRecommendation();
        yield DataLoaded(
            data: _data.list,
            cursor: _data.cursor,
            hasReachedMax: _data.list.length < count ? true : false);
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }
    if (event is FetchMoreRecommentations && !_hasReachedMax(currentState)) {
      try {
        if (currentState is DataLoaded) {
          TournamentResponse _data =
              await _fetchRecommendation(cursor: currentState.cursor);
          if (_data.list != null && _data.list.isEmpty == false) {
            yield DataLoaded(
                data: currentState.data + _data.list,
                hasReachedMax: false,
                cursor: _data.cursor);
          } else {
            yield DataLoaded(
                data: currentState.data.list,
                hasReachedMax: true,
                cursor: _data.cursor);
          }
        }
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }
  }

  Future<TournamentResponse> _fetchRecommendation({String cursor}) async {
    try {
      String _cursor = '';
      if (cursor != null && cursor != '') {
        _cursor = '&cursor=$_cursor';
      }
      final ResponseModel _response = await _dbServices.getapi(
          '/tournament/api/tournaments_list_v2?limit=$count&status=all$_cursor');
      if (_response.statusCode == 200 && _response.data['success'] == true) {
        final _res = _response.data['data']['data'] != null
            ? _response.data['data']['data']['tournaments']
            : _response.data['data']['tournaments'];
        List<Tournament> _list =
            _res.map<Tournament>((i) => Tournament.fromJson(i)).toList();
        return TournamentResponse(
            list: _list, cursor: _response.data['data']['cursor']);
      } else {
        throw ('Something went wrong');
      }
    } catch (e) {
      throw(e);
    }
  }

  bool _hasReachedMax(HomeState state) =>
      state is DataLoaded && state.hasReachedMax;
}
