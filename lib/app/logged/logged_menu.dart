import 'package:mini_vera/app/logged/logged.dart';
import 'package:operation_cubit/operation.dart';
import 'package:operation_cubit/operation_cubit.dart';

enum LoggedMenuProps { playerLogged }

enum LoggedMenuExits {
  loadMasterLedger,
  loadCourseRegistration,
  checkExamRegistration,
  checkCourseRegistration,
  logOut
}

class LoggedMenuBaseState extends OperationState {
  LoggedMenuBaseState();

  // @override
  // List<Object?> get props => [playerLogged];
}

class LoggedMenu extends Logged {
  late LoggedMenuBaseState loggedMenuBaseState;

  LoggedMenu({super.children, required super.blocProviderBuilder});

  loadMasterLedger() {
    exitOperation(
        OCResult.success(statusOnExit: LoggedMenuExits.loadMasterLedger));
  }

  checkExamRegistration() {
    exitOperation(
        OCResult.success(statusOnExit: LoggedMenuExits.checkExamRegistration));
  }

  loadCourseRegistration() {
    exitOperation(
        OCResult.success(statusOnExit: LoggedMenuExits.loadCourseRegistration));
  }

  checkCourseRegistration() {
    exitOperation(OCResult.success(
        statusOnExit: LoggedMenuExits.checkCourseRegistration));
  }

  @override
  logOut() {
    exitOperation(OCResult.success(statusOnExit: LoggedMenuExits.logOut));
  }

  @override
  Future<(ChildOperation, Map<Enum, dynamic>)?> initialize(
      {required Operation parent, required Map<Enum, dynamic>? args}) async {
    parent as Logged;
    loggedMenuBaseState = LoggedMenuBaseState();
    userLogged = parent.userLogged;
    emit(loggedMenuBaseState);
    return null;
  }
}
