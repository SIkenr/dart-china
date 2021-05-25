import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(LoginState());

  final AuthRepository _authRepository;

  check() async {
    var login = await _authRepository.checkLogin();
    if (login) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var username = prefs.getString('username');
      if (username != null && username.isNotEmpty) {
        var user = await _authRepository.userInfo(username);
        emit(state.copyWith(
          loading: false,
          isLogin: true,
          user: user,
        ));
      }
    }
  }

  returnRoute(String route) {
    emit(state.copyWith(returnRoute: route));
  }

  login(String username, String password) async {
    emit(state.copyWith(
      loading: true,
      isLogin: false,
      user: null,
    ));
    var user = await _authRepository.login(username, password);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.username);

    emit(state.copyWith(
      loading: false,
      isLogin: true,
      user: user,
    ));
  }

  logout(String username) async {
    await _authRepository.logout(username);
    emit(state.copyWith(
      isLogin: false,
      user: null,
    ));
  }
}