import 'package:dash/apis/auth_api.dart';
import 'package:dash/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authApi: ref.watch(authAPIProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authApi})
      : _authAPI = authApi,
        super(false); // Initially bool state=isLoading is false

  void signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;

    res.fold((l) => showSnackbar(context, l.message), (r) => print(r.email));
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;

    res.fold((l) => showSnackbar(context, l.message), (r) => print(r.userId));
  }
}
