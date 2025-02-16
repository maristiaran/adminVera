import 'package:mini_vera/app/logged/logged_menu.dart';
import 'package:mini_vera/app/signin.dart';
import 'package:mini_vera/domain/entities/admins.dart';
import 'package:mini_vera/mini_vera_app.dart';
import 'package:operation_cubit/operation.dart';
import 'package:operation_cubit/operation_cubit.dart';

enum LoggedProps { userLogged }

class LoggedBaseState extends OperationState {
  LoggedBaseState(
      // {required this.playerLogged}
      );
}

class Logged extends ChildOperation {
  late IESAdmin userLogged;
  Logged({super.children, required super.blocProviderBuilder});
  @override
  bool get isAbstract => true;

  logOut() {
    exitOperation(OCResult.success(statusOnExit: MiniVeraOperation.signIn));
  }

  @override
  onResumeAfterChildOperationExiting(
      {required ChildOperation lastChildOperation,
      required OCResult lastChildOperationResult}) {
    goParentOperation();

    if (lastChildOperationResult.isSuccessful) {
      if (lastChildOperation.title == MiniVeraOperation.chooseLoggedOperation) {
        switch (lastChildOperationResult.statusOnExit) {
          case LoggedMenuExits.logOut:
            exitOperation(
                OCResult.success(statusOnExit: MiniVeraOperation.signIn));
            break;
          case LoggedMenuExits.loadMasterLedger:
            goChildOperation(title: MiniVeraOperation.loadMasterLedger);
            break;
          case LoggedMenuExits.loadCourseRegistration:
            goChildOperation(title: MiniVeraOperation.uploadCourseRecords);
            break;
        }
        // } else if (lastChildOperation.title == MiniVeraOperation.chooseLoggedOperation) {
        //   goChildOperation(title: FrutalityOperation.chooseLoggedOperation);
        // } else {
        //   goChildOperation(
        //       title: FrutalityOperation.playGame,
        //       args: lastChildOperationResult.args);
        // }
      } else {
        exitOperation(OCResult.fail(message: 'Unknown error'));
      }
    }
  }

  @override
  Future<(ChildOperation, Map<Enum, dynamic>)?> initialize(
      {required Operation parent, required Map<Enum, dynamic>? args}) async {
    userLogged = args![SignInProps.iesUser];
    var chooseLoggedOperation =
        childOperation(MiniVeraOperation.chooseLoggedOperation);
    return (chooseLoggedOperation, {LoggedProps.userLogged: userLogged});
  }
}
