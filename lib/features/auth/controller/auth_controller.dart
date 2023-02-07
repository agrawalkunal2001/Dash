import 'package:dash/apis/auth_api.dart';
import 'package:dash/apis/user_api.dart';
import 'package:dash/core/utils.dart';
import 'package:dash/features/auth/view/login_view.dart';
import 'package:dash/features/home/view/home_view.dart';
import 'package:dash/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart' as model;

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authAPIProvider), userAPI: ref.watch(userAPIProvider));
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false); // Initially bool state=isLoading is false

  Future<model.Account?> currentUser() {
    return _authAPI.currentUserAccount();
  }

  void signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;

    res.fold((l) => showSnackbar(context, l.message), (r) async {
      UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          followers: const [],
          following: const [],
          profilePic: "",
          bannerPic: "",
          uid: "",
          bio: "",
          isTwitterBlue: false);
      final res2 = await _userAPI.saveUserData(userModel);

      res2.fold((l) => showSnackbar(context, l.message), (r) {
        showSnackbar(context, "Account created successfully! Please login.");
        Navigator.push(context, LoginView.route());
      });
    });
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;

    res.fold((l) => showSnackbar(context, l.message), (r) {
      Navigator.push(context, HomeView.route());
    });
  }
}
