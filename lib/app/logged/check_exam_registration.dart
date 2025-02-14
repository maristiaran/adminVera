import 'package:mini_vera/app/logged/logged.dart';
import 'package:operation_cubit/operation.dart';
import 'package:operation_cubit/operation_cubit.dart';

enum CheckExamRegistrationProps { playerLogged }

enum CheckExamRegistrationExits {
  loadMasterLedger,
  loadCourseRegistration,
  checkExamRegistration,
  checkCourseRegistration,
  logOut
}

class CheckExamRegistrationBaseState extends OperationState {
  CheckExamRegistrationBaseState();

  // @override
  // List<Object?> get props => [playerLogged];
}

class CheckExamRegistration extends Logged {
  late CheckExamRegistrationBaseState loggedMenuBaseState;

  CheckExamRegistration({super.children, required super.blocProviderBuilder});

  loadMasterLedger() {
    exitOperation(OCResult.success(
        statusOnExit: CheckExamRegistrationExits.loadMasterLedger));
  }

  checkExamRegistration() {
    exitOperation(OCResult.success(
        statusOnExit: CheckExamRegistrationExits.checkExamRegistration));
  }

  loadCourseRegistration() {
    exitOperation(OCResult.success(
        statusOnExit: CheckExamRegistrationExits.loadCourseRegistration));
  }

  checkCourseRegistration() {
    exitOperation(OCResult.success(
        statusOnExit: CheckExamRegistrationExits.checkCourseRegistration));
  }

  categories() {}
  shop() {}
  friendsAndTeams() {}
  preferences() {}
  adjustVolume() {}

  @override
  logOut() {
    exitOperation(
        OCResult.success(statusOnExit: CheckExamRegistrationExits.logOut));
  }

  @override
  Future<(ChildOperation, Map<Enum, dynamic>)?> initialize(
      {required Operation parent, required Map<Enum, dynamic>? args}) async {
    parent as Logged;
    loggedMenuBaseState = CheckExamRegistrationBaseState();
    userLogged = parent.userLogged;
    emit(loggedMenuBaseState);
    return null;
  }
}
