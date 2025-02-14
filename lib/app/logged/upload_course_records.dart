import 'package:mini_vera/domain/entities/users.dart';
import 'package:operation_cubit/operation.dart';
import 'package:operation_cubit/operation_cubit.dart';

enum MainMenuProps { ctUserLogged }

enum MainMenuExits { cancel, playRound }

class UploadCourseRecordsBaseState extends OperationState {
  IESAdminUser? userLoggedIfAny;
  // CTUnit? currentCTUnitIfAny;
  // CTTopic? currentCTTopicIfAny;
  UploadCourseRecordsBaseState({required this.userLoggedIfAny}
      // required this.currentCTUnitIfAny,
      // required this.currentCTTopicIfAny}

      );

  @override
  bool operator ==(Object other) =>
      other is UploadCourseRecordsBaseState &&
      other.userLoggedIfAny == userLoggedIfAny;
  // other.currentCTUnitIfAny == currentCTUnitIfAny &&
  // other.currentCTTopicIfAny == currentCTTopicIfAny;

  @override
  int get hashCode => userLoggedIfAny.hashCode;
}

class UploadCourseRecords extends ChildOperation {
  late UploadCourseRecordsBaseState lastLoadCourseBaseState;
  // late List<CTUnit> ctUnits;
  // int currentCTUnitIndex = 0;
  UploadCourseRecords({super.children, required super.blocProviderBuilder});
  // CTUnit get currentCTUnit => ctUnits[currentCTUnitIndex];
  // CTTopic get currentCTTopic => currentCTUnit.currentCTTopic;

  cancel() {
    exitOperation(OCResult.success(statusOnExit: MainMenuExits.cancel));
  }

  @override
  Future<(ChildOperation, Map<Enum, dynamic>)?> initialize(
      {required Operation parent, required Map<Enum, dynamic>? args}) async {
    // playerLogged = (parent as PlayingGame).playerLogged;
    // currentGame = parent.currentGame;

    lastLoadCourseBaseState = UploadCourseRecordsBaseState(
      userLoggedIfAny: null,
    );

    emit(lastLoadCourseBaseState);
    return null;
  }

  goHome() {
    lastLoadCourseBaseState = UploadCourseRecordsBaseState(
      userLoggedIfAny: lastLoadCourseBaseState.userLoggedIfAny,
    );
    emit(lastLoadCourseBaseState);
  }
}
