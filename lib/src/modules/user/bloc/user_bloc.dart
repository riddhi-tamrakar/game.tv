import 'dart:async';
import 'package:app/src/modules/user/models/user.dart';
import 'package:app/src/services/db_service.dart';
import 'package:app/src/services/db_service_response.model.dart';
import 'package:app/src/services/shared_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  final SharedPreferencesFn _sharedPref = SharedPreferencesFn();
  final DbServices _dbServices = DbServices();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is InitLogin) {
      try {
        bool result = await initiateAutoLogin();
        if (result) {
          yield LoginSuccess();
        } else {
          yield ErrorReceived();
        }
      } catch (e) {
        print(e);
        yield ErrorReceived(err: e);
      }
    }

    if (event is PerfomLogin) {
      try {
        yield Loading();
        bool result = await login(event.email, event.password);
        if (result != null && result) {
          yield LoginSuccess();
        } else {
          yield InvalidCredentials();
        }
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }

    if (event is LogOut) {
      yield Loading();
      // await resetDeviceId();
      bool flag = await louout();
      print(flag);
      yield flag ? LoggedOut() : ErrorReceived();
    }

    if (event is FetchUserDetails) {
      try {
        yield Loading();
        User _user = await _fetchUserDetails();
        yield UserDataLoaded(data: _user);
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }
    //
  }

  Future<bool> login(email, password) async {
    try {
      await Future.delayed(
          Duration(seconds: 2)); // Mocking an API call for Login
      if ((email == '9898989898' && password == 'password123') ||
          (email == '9876543210' && password == 'password123')) {
        await _sharedPref.setString('email', email);
        await _sharedPref.setString('password', password);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw (e);
    }
  }

  initiateAutoLogin() async {
    try {
      final _email = await _sharedPref.getString('email');
      final _password = await _sharedPref.getString('password');
      if (_email != '' && _password != '') {
        bool result = await login(_email, _password);
        return result;
      } else {
        throw ('');
      }
    } catch (e) {
      throw (e);
    }
  }

  Future louout() async {
    try {
      await _sharedPref.setString('email', '');
      await _sharedPref.setString('password', '');
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<User> _fetchUserDetails() async {
    try {
      final ResponseModel _response =
          await _dbServices.getapi('/userDetail', isMockAPI: true);
      if (_response.statusCode == 200) {
        if (_response.data != null && _response.data.length > 0) {
          return User.fromJson(_response.data[0]);
        } else {
          throw ('Something went wrong');
        }
      } else {
        throw ('Something went wrong');
      }
    } catch (e) {}
  }
}
