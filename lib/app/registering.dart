import 'package:operation_cubit/operation.dart';
import 'package:operation_cubit/operation_cubit.dart';

enum RegisteringExits { cancel, registered }

enum RegisteringProps { userName, password, email, phone }

class RegisteringBaseState extends OperationState {
  String userName;
  String email;
  String password;
  int phone;

  RegisteringBaseState(
      {required this.userName,
      required this.email,
      required this.password,
      required this.phone});

  // @override
  // List<Object?> get props => [userName, phone, password, email];
}

class Registering extends ChildOperation {
  late RegisteringBaseState lastRegisteringBaseState;

  Registering({super.children, required super.blocProviderBuilder});

  cancel() {}

  @override
  Future<(ChildOperation, Map<Enum, dynamic>)?> initialize(
      {required Operation parent, required Map<Enum, dynamic>? args}) async {
    lastRegisteringBaseState = RegisteringBaseState(
        userName: args![RegisteringProps.userName] ?? '',
        email: args[RegisteringProps.email] ?? '',
        password: args[RegisteringProps.password] ?? '',
        phone: args[RegisteringProps.phone] ?? 0);
    return null;
  }

  register(
      {required String email,
      required String password,
      required String username}) async {
    // try {
    //   await Tools()
    //       .repoFirestoreAuthInstance
    //       .createUserWithEmailAndPassword(email: email, password: password);
    //   CTUser? aPlayerIfAny = (await Tools()
    //           .repoUsersRepository
    //           .registerNewPlayer(email: email, username: username))
    //       .fold((left) => null, (aPlayer) => aPlayer);

    //   if (aPlayerIfAny == null) {
    //     exitOperation(
    //         OCResult.fail(message: 'No se puede registrar el usuario'));
    //   } else {
    //     exitOperation(OCResult.success(
    //         statusOnExit: CodingTilesOperation.main,
    //         args: {MainMenuProps.ctUserLogged: aPlayerIfAny}));
    //   }

    //   exitOperation(OCResult.success(
    //       statusOnExit: MainMenuProps.ctUserLogged,
    //       args: {MainMenuProps.ctUserLogged: aPlayerIfAny}));
    // } catch (e) {
    //   exitOperation(OCResult.fail(message: e.toString()));
    // }
  }
}
