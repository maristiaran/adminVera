import 'package:mini_vera/domain/entities/users.dart';

enum SubjectState { approved, regular, dissaproved, coursing, nule }

// Student Record subject
class StudentRecordSubject {
  int subjectId;
  DateTime? finalExamDateIfAny;
  String finalExamGrade;
  DateTime? courseDateIfAny;
  String courseGrade;
  IESAdminUser admin;
  // bool endCourseApproval = false;
  // bool coursing = false;

  // SubjectState get subjectState {
  //   if (finalExamDateIfAny != null) {
  //     return SubjectState.approved;
  //   } else if (courseDateIfAny != null) {
  //     return SubjectState.regular;
  //   } else if (coursing) {
  //     return SubjectState.coursing;
  //   } else {
  //     return SubjectState.nule;
  //   }
  // }

  StudentRecordSubject(
      {required this.subjectId,
      required this.finalExamDateIfAny,
      required this.finalExamGrade,
      required this.courseDateIfAny,
      required this.admin,
      required this.courseGrade});
}

class IESStudentUser {
  String firstName;
  String lastName;
  String id;
  String email;
  int dni;
  int book;
  int page;
  List<StudentRecordSubject> subjectRecords = [];
  IESStudentUser(
      {required this.firstName,
      required this.lastName,
      required this.id,
      required this.email,
      required this.dni,
      required this.book,
      required this.page});

  @override
  String toString() {
    return '$lastName, $firstName, DNI: $dni, Libro: $book, Folio: $page ';
  }
}
