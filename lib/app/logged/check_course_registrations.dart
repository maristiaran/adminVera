import 'package:mini_vera/app/logged/logged.dart';
import 'package:operation_cubit/operation.dart';
import 'package:operation_cubit/operation_cubit.dart';

enum CheckCourseRegistrationProps { playerLogged }

enum CheckCourseRegistrationExits {
  loadMasterLedger,
  loadCourseRegistration,
  checkExamRegistration,
  checkCourseRegistration,
  logOut
}

class CheckCourseRegistrationBaseState extends OperationState {
  CheckCourseRegistrationBaseState();

  // @override
  // List<Object?> get props => [playerLogged];
}

class CheckCourseRegistration extends Logged {
  late CheckCourseRegistrationBaseState loggedMenuBaseState;

  CheckCourseRegistration({super.children, required super.blocProviderBuilder});

  loadMasterLedger() {
    exitOperation(OCResult.success(
        statusOnExit: CheckCourseRegistrationExits.loadMasterLedger));
  }

  checkExamRegistration() {
    exitOperation(OCResult.success(
        statusOnExit: CheckCourseRegistrationExits.checkExamRegistration));
  }

  loadCourseRegistration() {
    exitOperation(OCResult.success(
        statusOnExit: CheckCourseRegistrationExits.loadCourseRegistration));
  }

  checkCourseRegistration() {
    exitOperation(OCResult.success(
        statusOnExit: CheckCourseRegistrationExits.checkCourseRegistration));
  }

  categories() {}
  shop() {}
  friendsAndTeams() {}
  preferences() {}
  adjustVolume() {}

  @override
  logOut() {
    exitOperation(
        OCResult.success(statusOnExit: CheckCourseRegistrationExits.logOut));
  }

  @override
  Future<(ChildOperation, Map<Enum, dynamic>)?> initialize(
      {required Operation parent, required Map<Enum, dynamic>? args}) async {
    parent as Logged;
    loggedMenuBaseState = CheckCourseRegistrationBaseState();
    userLogged = parent.userLogged;
    emit(loggedMenuBaseState);
    return null;
  }
}
