import 'package:mini_vera/repositories/tools.dart';
import 'package:operation_cubit/operation.dart';
import 'package:operation_cubit/operation_cubit.dart';

enum SignInExits { cancel, sessionStarted }

enum SignInProps { userName, password, iesUser }

class SignInBaseState extends OperationState {
  String userName = '';
  String password = '';
  SignInBaseState();

  // @override
  // List<Object?> get props => [userName, password];
}

enum SignInFailureName {
  userNotVerified,
}

class SignIn extends ChildOperation {
  SignIn({super.children, required super.blocProviderBuilder});
  late SignInBaseState lastSignInBaseState;
  @override
  Future<(ChildOperation, Map<Enum, dynamic>)?> initialize(
      {required Operation parent, required Map<Enum, dynamic>? args}) async {
    lastSignInBaseState = SignInBaseState();
    return null;
  }

  // register() => exitOperation(
  //     OCResult.success(statusOnExit: CodingTilesOperation.registering));

  signInWithUsernameOrEmail(
      {required String userNameOrEmail, required String password}) async {
    // CTUser? ctUserIfAny;

    // ctUserIfAny = userNameOrEmail.contains('@')
    //     ? (await Tools()
    //             .repoUsersRepository
    //             .getPlayerByEmail(email: userNameOrEmail))
    //         .fold((left) => null, (right) => right)
    //     : (await Tools()
    //             .repoUsersRepository
    //             .getPlayerByUsername(username: userNameOrEmail))
    //         .fold((left) => null, (right) => right);

    // if (ctUserIfAny == null) {
    //   exitOperation(OCResult.fail(message: 'Jugador no registrado'));
    // } else {
    //   try {
    //     await Tools().repoFirestoreAuthInstance.signInWithEmailAndPassword(
    //         email: ctUserIfAny.email, password: password);
    //     exitOperation(OCResult.success(
    //         statusOnExit: SignInExits.sessionStarted,
    //         args: {MainMenuProps.ctUserLogged: ctUserIfAny}));
    //   } catch (e) {
    //     exitOperation(OCResult.fail(message: e.toString()));
    //   }
    // }
  }

  Future adminSignIn(String email, String password) async {
    // try {

    (await Tools()
            .repoUsersRepository
            .loginAndVerifyAdmin(email: email, password: password))
        .fold(
            (failure) => emitError('El usuario no pudo ser verificado'),
            (verifiedAdminUser) => exitOperation(OCResult.success(
                statusOnExit: SignInExits.sessionStarted,
                args: {SignInProps.iesUser: verifiedAdminUser})));

    //   exitOperation(OCResult.success(
    //       statusOnExit: SignInExits.sessionStarted,
    //       args: {SignInProps.iesUser: validAdmins[email]}));
    // } on Exception {
    //   emitError('El usuario no pudo ser verificado');
    // }
  }

  // Future signIn(String email, String password) async {
  //   Map<String, IESAdminUser> validAdmins = {
  //     'martin.aristiaran@gmail.com': IESAdminUser(
  //         firstName: 'Martín',
  //         lastName: 'Aristiaran',
  //         id: '',
  //         email: 'martin.aristiaran@gmail.com',
  //         syllabusID: 'Coordinador Tec. Sup. en Desarrollo de Software',
  //         birthdate: DateTime.now(),
  //         dni: 12345678),
  //     'testarosanadelvalle@gmail.com': IESAdminUser(
  //         firstName: 'Rosana',
  //         lastName: 'Testa',
  //         id: '',
  //         email: 'testarosanadelvalle@gmail.com',
  //         syllabusID: 'Bedel Tec. Sup. en Desarrollo de Software',
  //         birthdate: DateTime.now(),
  //         dni: 12345678),
  //   };

  //   if (validAdmins.keys.contains(email)) {
  //     try {
  //       await Tools()
  //           .repoFirestoreAuthInstance
  //           .signInWithEmailAndPassword(email: email, password: password);

  //       exitOperation(OCResult.success(
  //           statusOnExit: SignInExits.sessionStarted,
  //           args: {SignInProps.iesUser: validAdmins[email]}));
  //     } on Exception {
  //       emitError('El usuario no pudo ser verificado');
  //     }
  //   }
  // }

  // signInWithGoogle() async {
  //   // if (googleSignIn.currentUser != null) {
  //   //   googleSignIn.signOut();
  //   // }
  //   User? user;
  //   GoogleAuthProvider authProvider = GoogleAuthProvider();
  //   Tools().repoGoogleSignIn.signOut();
  //   var googleUser = await Tools().repoGoogleSignIn.signIn();
  //   if (googleUser == null) {
  //     exitOperation(OCResult.fail(message: 'Usuario no existente'));
  //   } else {
  //     // final googleAuth = await googleUser.authentication;
  //     // final credential = GoogleAuthProvider.credential(
  //     //     accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  //     // await firestoreAuthInstance.signInWithCredential(credential);
  //     // String googleUserName = googleUser.displayName ?? googleUser.email;
  //     try {
  //       final UserCredential userCredential = await Tools()
  //           .repoFirestoreAuthInstance
  //           .signInWithPopup(authProvider);
  //       user = userCredential.user;
  //     } catch (e) {
  //       print(e);
  //     }

  //     if (user != null) {
  //       exitOperation(
  //           OCResult.success(statusOnExit: SignInExits.sessionStarted, args: {
  //         SignInProps.iesUser: IESAdminUser(
  //             username: user.displayName ?? '',
  //             id: user.uid,
  //             email: user.email ?? '')
  //       }));

  //       // SharedPreferences prefs = await SharedPreferences.getInstance();
  //       // prefs.setBool('auth', true);
  //       // print("name: $name");
  //       // print("userEmail: $userEmail");
  //       // print("imageUrl: $imageUrl");
  //     } else {
  //       exitOperation(OCResult.fail(message: 'Administrador no verificado'));
  //     }
  //     //   await Tools()
  //     //       .repoUsersRepository
  //     //       .getAdminUserByEmail(email: googleUser.email)
  //     //       .then((value) => value.fold((failure) async {
  //     //             exitOperation(
  //     //                 OCResult.fail(message: 'Administrador no verificado'));
  //     //           }, (iesUser) {
  //     //             exitOperation(OCResult.success(
  //     //                 statusOnExit: SignInExits.sessionStarted,
  //     //                 args: {SignInProps.iesUser: iesUser}));
  //     //           }));
  //     // } catch (e) {
  //     //   exitOperation(
  //     //       OCResult.fail(message: 'Error al verificar el administrador'));
  //     // }
  //   }
  // }

  signInWithFacebook() async {}

  // SignInWithFacebook(
  //     ) async {
  //   await facebookAuth.logOut();

  //   SignInResult facebookUser =
  //       await facebookAuth.SignIn(permissions: ["public_profile", "email"]);
  //   if (facebookUser.status != SignInStatus.success) {
  //          exitOperation(OCResult.fail(message: 'Usuario no existente'));

  //   } else {
  //     Map<String, dynamic> userMap = await facebookAuth.getUserData();
  //     String facebookUserName = userMap["name"];

  //     Player? aPlayerIfAny = await (parentOperation as Auth)
  //         .registeredPlayerIfNot(
  //             email: _googleUser!.email, userName: facebookUserName);

  //     if (aPlayerIfAny == null) {
  //       emit(const LSError(errorMessage: 'No se puede registrar el usuario'));
  //     } else {
  //       emit(const SuccessfullySignInState());
  //       parentOperation.add(AESuccessfullyLogged(player: aPlayerIfAny));
  //     }
  //   }
  // }
}
