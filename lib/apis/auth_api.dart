import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:dash/core/failure.dart';
import 'package:dash/core/providers.dart';
import 'package:dash/core/type_defs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

// Want to signup, get user account=>Account
// Want to access user data=>model.Account

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  FutureEither<model.Account> signUp(
      {required String email, required String password});
  FutureEither<model.Session> login(
      {required String email, required String password});
} // This abstract class contains all functions that will be used in AuthAPI class. This is useful if we change backend implementation. The functions will remain same while we can implement it using any backend.

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  FutureEither<model.Account> signUp(
      {required String email, required String password}) async {
    try {
      final acc = await _account.create(
          userId: ID.unique() /*Appwrite will create a unique user id */,
          email: email,
          password: password);

      return right(acc);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? "Some unexpected error occurred!", stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEither<model.Session> login(
      {required String email, required String password}) async {
    try {
      final session =
          await _account.createEmailSession(email: email, password: password);
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? "Some unexpected error occurred!", stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
