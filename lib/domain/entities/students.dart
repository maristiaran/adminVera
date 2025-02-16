import 'package:mini_vera/domain/entities/users.dart'; // Importar las clases necesarias

class IESStudent {
  String firstname;
  String surname;
  String id;
  final int dni;
  int book;
  int page;
  String syllabusID;
  List<StudentRecordSubject> subjectRecords = [];
  IESStudent({
    required this.firstname,
    required this.surname,
    required this.id,
    required this.dni,
    required this.book,
    required this.page,
    required this.syllabusID,
  });

  // Nuevo constructor
  IESStudent.fromUserAndRole(IESUser user, IESStudentRole role)
      : firstname = user.firstname,
        surname = user.surname,
        id = user.id,
        dni = user.dni,
        book = role.book,
        page = role.page,
        syllabusID = role.syllabusID;
}

enum SubjectState { approved, regular, dissaproved, coursing, nule }

class StudentRecordSubject {
  int subjectId;
  DateTime? finalExamDateIfAny;
  String finalExamGrade;
  DateTime? courseDateIfAny;
  String courseGrade;
  String adminID;

  StudentRecordSubject({
    required this.subjectId,
    required this.finalExamDateIfAny,
    required this.finalExamGrade,
    required this.courseDateIfAny,
    required this.adminID,
    required this.courseGrade,
  });
}
