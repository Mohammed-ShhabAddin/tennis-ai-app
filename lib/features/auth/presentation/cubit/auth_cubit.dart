import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/login_model.dart';
import '../../data/models/signup_model.dart';
import '../../data/repos/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> signUp(SignupModel signupModel) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signUp(signupModel);
      if (user != null) {
        emit(AuthSuccess(user));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(LoginModel loginModel) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(loginModel);
      if (user != null) {
        emit(AuthSuccess(user));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(AuthLoggedOut());
  }
}
