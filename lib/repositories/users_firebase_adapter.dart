import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_vera/domain/entities/users.dart';
import 'package:mini_vera/domain/repository_ports/users_repository_port.dart';
import 'package:mini_vera/domain/utils/datetime.dart';
import 'package:mini_vera/domain/utils/responses.dart';
import 'package:mini_vera/repositories/tools.dart';

class UsersRepositoryFirestoreAdapter implements UsersRepositoryPort {
  @override
  Future<Either<Failure, IESAdminUser>> loginAndVerifyAdmin(
      {required String email, required String password}) async {
    try {
      // 1. Autenticar usuario con FirebaseAuth
      UserCredential userCredential =
          await Tools().repoFirestoreAuthInstance.signInWithEmailAndPassword(
                email: email,
                password: password,
              );

      // 2. Obtener usuario autenticado
      User? user = userCredential.user;
      if (user == null) {
        return Left(Failure(
            failureName: FailureName.unknown,
            message: "No se pudo autenticar el usuario."));
      }

      // 3. Buscar usuario en Firestore en la colección iesUsers
      QuerySnapshot usersSnapshot = await Tools()
          .repoFirestoreInstance
          .collection('iesUsers')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (usersSnapshot.docs.isEmpty) {
        return Left(Failure(
            failureName: FailureName.unknown,
            message: "El usuario no está registrado en iesUsers."));
      }

      // 4. Obtener datos del usuario
      var userData = usersSnapshot.docs.first.data() as Map<String, dynamic>;

      // 5. Obtener la colección de roles del usuario
      QuerySnapshot rolesSnapshot = await Tools()
          .repoFirestoreInstance
          .collection('iesUsers')
          .doc(usersSnapshot.docs.first.id)
          .collection('roles')
          .get();

      List<Map<String, dynamic>> roles = rolesSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      List<Map<String, dynamic>> adminRoles = roles
          .where((role) => role['role'] == 'administrative')
          .map((role) => role)
          .toList();

      bool isAdmin = adminRoles.isNotEmpty;
      if (!isAdmin) {
        return Left(Failure(
            failureName: FailureName.unknown,
            message: "El usuario no tiene permisos administrativos."));
      }

      // Crear una lista de syllabusIDs con los valores 'syllabus' de cada rol administrativo
      List<String> syllabusIDs =
          adminRoles.map((role) => role['syllabus']! as String).toList();

      // 6. Retornar una instancia de IESAdminUser
      return Right(IESAdminUser(
        id: user.uid,
        email: user.email!,
        firstName: userData['firstname'],
        lastName: userData['surname'],
        birthdate: stringToDate(userData['birthdate']),
        dni: userData['dni'],
        syllabusIDs: syllabusIDs,
      ));
    } catch (e) {
      return Left(Failure(
          failureName: FailureName.unknown,
          message: "Error al iniciar sesión: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Success>> resetPasswordEmail(
      {required String email}) async {
    try {
      await Tools()
          .repoFirestoreAuthInstance
          .sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      return Left(Failure(
          failureName: UsersRepositoryFailureName.cantResetPassword,
          message: 'No se pudo restaurar la contraseña'));
    }
    return Right(Success(''));
  }

  @override
  Either<Failure, Success> reSendEmailVerification() {
    if (Tools().repoFirestoreAuthInstance.currentUser == null) {
      return Left(Failure(
          failureName: UsersRepositoryFailureName.cantSentVerificationEmail,
          message: 'No se pudo enviar el email de verificación'));
    } else {
      Tools().repoFirestoreAuthInstance.currentUser!.sendEmailVerification();
      return Right(Success(''));
    }
  }

  @override
  Future<bool> getCurrentUserIsEMailVerified() async {
    if ((Tools().repoFirestoreAuthInstance.currentUser != null)) {
      await Tools().repoFirestoreAuthInstance.currentUser!.reload();

      return Tools().repoFirestoreAuthInstance.currentUser!.emailVerified;
    } else {
      return false;
    }
  }
}
