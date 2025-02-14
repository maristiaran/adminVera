import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_vera/app/logged/check_course_registrations.dart';
import 'package:mini_vera/app/logged/check_exam_registration.dart';
import 'package:mini_vera/app/logged/load_master_ledger.dart';
import 'package:mini_vera/app/logged/load_master_ledger_page.dart';
import 'package:mini_vera/app/logged/logged.dart';
import 'package:mini_vera/app/logged/logged_menu.dart';
import 'package:mini_vera/app/logged/logged_menu_page.dart';
import 'package:mini_vera/app/logged/upload_course_records.dart';
import 'package:mini_vera/app/logged/upload_course_records_page.dart';
import 'package:mini_vera/app/signin.dart';
import 'package:mini_vera/app/signin_page.dart';
import 'package:operation_cubit/operation.dart';
import 'package:operation_cubit/operation_cubit.dart';
import 'package:operation_cubit/operation_system.dart';

enum MiniVeraOperation {
  signIn,
  // registering,
  logged,
  chooseLoggedOperation,
  loadMasterLedger,
  checkExamRegistration,
  checkCourseRegistration,
  uploadCourseRecords
}

OperationsSystem miniVera =
    MiniVera(appName: 'Mini Vera', startingViewSeconds: 1, children: {
  MiniVeraOperation.signIn: SignIn(
      blocProviderBuilder: (context, operation) => BlocProvider<SignIn>.value(
          value: operation as SignIn, child: SignInPage(operation: operation))),
  // MiniVeraOperation.registering: Registering(
  //     blocProviderBuilder: (context, operation) =>
  //         BlocProvider<Registering>.value(
  //             value: operation as Registering,
  //             child: RegisteringPage(operation: operation))),
  MiniVeraOperation.logged: Logged(
      blocProviderBuilder: (context, operation) => BlocProvider<Logged>.value(
          value: operation as Logged,
          child: Container(
            color: Colors.grey,
          )),
      children: {
        MiniVeraOperation.chooseLoggedOperation: LoggedMenu(
            blocProviderBuilder: (context, operation) =>
                BlocProvider<LoggedMenu>.value(
                    value: operation as LoggedMenu,
                    child: LoggedMenuPage(operation: operation))),
        MiniVeraOperation.loadMasterLedger: LoadMasterLedger(
            blocProviderBuilder: (context, operation) =>
                BlocProvider<LoadMasterLedger>.value(
                    value: operation as LoadMasterLedger,
                    child: LoadMasterLedgerPage(operation: operation))),
        MiniVeraOperation.uploadCourseRecords: UploadCourseRecords(
            blocProviderBuilder: (context, operation) =>
                BlocProvider<UploadCourseRecords>.value(
                    value: operation as UploadCourseRecords,
                    child: UploadCourseRecordsPage(operation: operation))),
        MiniVeraOperation.checkExamRegistration: CheckExamRegistration(
            blocProviderBuilder: (context, operation) =>
                BlocProvider<CheckExamRegistration>.value(
                    value: operation as CheckExamRegistration,
                    child: Container(
                      color: Colors.blue,
                    ))),
        MiniVeraOperation.checkCourseRegistration: CheckCourseRegistration(
            blocProviderBuilder: (context, operation) =>
                BlocProvider<CheckCourseRegistration>.value(
                    value: operation as CheckCourseRegistration,
                    child: Container(
                      color: Colors.blue,
                    )))
      })
});

class MiniVera extends OperationsSystem {
  bool isLogged = false;
  MiniVera({required super.appName, super.children, super.startingViewSeconds});

  @override
  Future<(ChildOperation, Map<Enum, dynamic>)?> initialize(
      {required Operation parent, required Map<Enum, dynamic>? args}) async {
    return null;
  }

  @override
  start() async {
    // if (Tools().repoFirestoreAuthInstance.currentUser != null) {
    //   var user = Tools().repoFirestoreAuthInstance.currentUser!;
    //   (await Tools().repoUsersRepository.getPlayerByEmail(email: user.email!))
    //       .fold(
    //           (left) => null,
    //           (player) => goChildOperation(
    //               title: CodingTilesOperation.main,
    //               args: {MainMenuProps.ctUserLogged: player}));
    // } else {
    //   goChildOperation(title: CodingTilesOperation.signIn);
    // }
    goChildOperation(title: MiniVeraOperation.signIn);
  }

  @override
  onResumeAfterChildOperationExiting(
      {required ChildOperation lastChildOperation,
      required OCResult lastChildOperationResult}) {
    goParentOperation();
    switch (lastChildOperation.title) {
      case MiniVeraOperation.signIn:
        if (lastChildOperationResult.isSuccessful) {
          if (lastChildOperationResult.statusOnExit ==
              SignInExits.sessionStarted) {
            return goChildOperation(
                title: MiniVeraOperation.logged,
                args: lastChildOperationResult.args);
          } else {
            // return goChildOperation(
            //     title: Mini,
            //     args: lastChildOperationResult.args);
          }
        } else {
          emit(OSErrorState(message: 'Unkown error '));
        }
        break;
      default:
    }
  }
}
