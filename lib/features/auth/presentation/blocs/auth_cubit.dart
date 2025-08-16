import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/user_model.dart';
import '../repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._authRepository,
  ) : super(AuthState());

  final AuthRepo _authRepository;

  Future<void> login(String email, String password) async {
    emit(state.copyWith(state: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    try {
      final user = await _authRepository.login(email, password);
      emit(state.copyWith(state: AuthStatus.loaded, user: () => user));
    } catch (e) {
      emit(state.copyWith(state: AuthStatus.error, message: e.toString()));
    }
  }
Future<void> signup({required String fullName,required String email,required String password}) async {
    emit(state.copyWith(state: AuthStatus.loading));
    try {
      final user = await _authRepository.signup(fullName,email, password);
      emit(state.copyWith(state: AuthStatus.loaded, user: () => user));
    } catch (e) {
      emit(state.copyWith(state: AuthStatus.error, message: "This email already exists"));
    }
  }

}
