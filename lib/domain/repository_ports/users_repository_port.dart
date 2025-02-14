import 'package:either_dart/either.dart';
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
  // Future<Either<Failure, IESAdminUser>> getIESUserByID(
  //     {required String idUser});
  // Future<Either<Failure, IESAdminUser>> getIESUserByDNI({required int dni});
  // Future<Either<Failure, IESAdminUser>> getIESUserByEmail(
  //     {required String email});
  Future<Either<Failure, Success>> resetPasswordEmail({required String email});

  Future<Either<Failure, IESAdminUser>> loginAndVerifyAdmin(
      {required String email, required String password});

  // Future<List<IESAdminUser>> getIESUsersByFullName(
  //     {required String surname, String? firstName});

  // Future<Either<Failure, String>> getUserEmail({required int dni});
  // Future<Either<Failure, IESAdminUser>> signInUsingEmailAndPassword(
  //     {String email, String password});
  // Future<Either<Failure, IESAdminUser>> registerNewIESUser(
  //     {required String email,
  //     required String password,
  //     required int dni,
  //     required String firstname,
  //     required String surname,
  //     required DateTime birthdate});
  reSendEmailVerification();
}
