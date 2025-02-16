import 'package:mini_vera/domain/entities/admins.dart';
import 'package:mini_vera/domain/entities/students.dart';
import 'package:mini_vera/domain/entities/syllabus.dart';

enum StudentsRepositoryFailureName {
  unknown,
  wrongUsernameOrPassword,
  notVerifiedEmail,
  cantResetPassword,
  cantSentVerificationEmail,
  userExists,
}

abstract class StudentsRepositoryPort {
  Future<List<StudentRecordSubject>> getStudentRecords(
      {required IESStudent studentUser, required IESAdmin admin});

  Future<void> updateSubjectRecord({
    required Syllabus syllabus,
    required IESStudent studentUser,
    required StudentRecordSubject subjectRecord,
    required IESAdmin admin,
  });

  Future<IESStudent> addStudent(
      {required Syllabus syllabus,
      required IESAdmin admin,
      required String firstName,
      required String lastName,
      required int dni,
      required int book,
      required int page});
}
