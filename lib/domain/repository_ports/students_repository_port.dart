import 'package:mini_vera/domain/entities/students.dart';
import 'package:mini_vera/domain/entities/syllabus.dart';
import 'package:mini_vera/domain/entities/users.dart';

enum StudentsRepositoryFailureName {
  unknown,
  wrongUsernameOrPassword,
  notVerifiedEmail,
  cantResetPassword,
  cantSentVerificationEmail,
  userExists,
}

abstract class StudentsRepositoryPort {
  Future<List<IESStudentUser>> searchStudentsByName(
      {String? firstName,
      required String lastName,
      required Syllabus syllabus});
  Future<List<StudentRecordSubject>> getStudentRecords(
      {required Syllabus syllabus,
      required IESStudentUser student,
      required IESAdminUser admin});
  Future<IESStudentUser> addStudent(
      {required Syllabus syllabus,
      required IESAdminUser admin,
      required String firstName,
      required String lastName,
      required int dni,
      required int book,
      required int page});

  // Future<List<IESStudentUser>> getIESUsersByFullName(
  //     {required String lastName, String? firstName});
  Future<void> updateSubjectRecord(
      {required Syllabus syllabus,
      required IESStudentUser student,
      required StudentRecordSubject subjectRecord,
      required IESAdminUser admin});
}
