import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_vera/domain/entities/admins.dart';
import 'package:mini_vera/domain/entities/users.dart';
import 'package:mini_vera/domain/repository_ports/users_repository_port.dart';
import 'package:mini_vera/domain/utils/datetime.dart';
import 'package:mini_vera/domain/utils/responses.dart';
import 'package:mini_vera/repositories/tools.dart';

class UsersRepositoryFirestoreAdapter implements UsersRepositoryPort {
  @override
  Future<Either<Failure, IESAdmin>> loginAndVerifyAdmin(
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

      List<IESAdminRole> adminRoles = rolesSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((role) => role['role'] == 'administrative')
          .map((role) => IESAdminRole(
              syllabusID: role['syllabus']!, id: usersSnapshot.docs.first.id))
          .toList();

      bool isAdmin = adminRoles.isNotEmpty;
      if (!isAdmin) {
        return Left(Failure(
            failureName: FailureName.unknown,
            message: "El usuario no tiene permisos administrativos."));
      }

      return Right(IESAdmin(
        id: user.uid,
        email: user.email!,
        firstname: userData['firstname'],
        surname: userData['surname'],
        dni: userData['dni'],
        currentSyllabusID: adminRoles.first.syllabusID,
        syllabusIDs: adminRoles.map((role) => role.syllabusID).toList(),
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

  @override
  Future<List<IESUser>> searchUsersByName(
      {String? firstname,
      required String surname,
      IESRoleForSearch? role}) async {
    try {
      // Crear una consulta base para buscar por apellido
      Query query = Tools()
          .repoFirestoreInstance
          .collection('iesUsers')
          .where('surname', isGreaterThanOrEqualTo: surname.trim())
          .where('surname', isLessThanOrEqualTo: '${surname.trim()}\uf8ff');

      // Si se proporciona el nombre, agregarlo a la consulta
      if (firstname != null && firstname.isNotEmpty) {
        query = query
            .where('firstname', isGreaterThanOrEqualTo: firstname.trim())
            .where('firstname',
                isLessThanOrEqualTo: '${firstname.trim()}\uf8ff');
      }

      // Ejecutar la consulta
      QuerySnapshot usersSnapshot = await query.get();

      // Si no se encuentra ningún documento, devolver una lista vacía
      if (usersSnapshot.docs.isEmpty) {
        return [];
      }

      // Crear y devolver una lista de instancias de IESUser
      return usersSnapshot.docs.map((doc) {
        var userData = doc.data() as Map<String, dynamic>;
        return IESUser(
          firstname: userData['firstname'],
          surname: userData['surname'],
          id: doc.id,
          birthdate: stringToDate(userData['birthdate']),
          email: userData['email'],
          dni: userData['dni'],
          roles: [], // Asignar roles según sea necesario
        );
      }).toList();
    } catch (e) {
      // Manejar errores y devolver una lista vacía en caso de excepción
      return [];
    }
  }
}
