import 'package:either_dart/either.dart';
import 'package:mini_vera/domain/entities/admins.dart';
import 'package:mini_vera/domain/entities/users.dart';
import 'package:mini_vera/domain/utils/responses.dart';

enum UsersRepositoryFailureName {
  unknown,
  wrongUsernameOrPassword,
  notVerifiedEmail,
  cantResetPassword,
  cantSentVerificationEmail,
  userExists,
}

abstract class UsersRepositoryPort {
  Future<bool> getCurrentUserIsEMailVerified();

  Future<List<IESUser>> searchUsersByName(
      {String? firstname, required String surname, IESRoleForSearch? role});

  Future<Either<Failure, Success>> resetPasswordEmail({required String email});

  Future<Either<Failure, IESAdmin>> loginAndVerifyAdmin(
      {required String email, required String password});

  reSendEmailVerification();
}
