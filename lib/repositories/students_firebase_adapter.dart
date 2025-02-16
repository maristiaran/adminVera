import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_vera/domain/entities/admins.dart';
import 'package:mini_vera/domain/entities/students.dart';
import 'package:mini_vera/domain/entities/syllabus.dart';
import 'package:mini_vera/domain/repository_ports/students_repository_port.dart';
import 'package:mini_vera/repositories/tools.dart';

class StudentsFirebaseAdapter implements StudentsRepositoryPort {
  @override
  Future<void> updateSubjectRecord(
      {required Syllabus syllabus,
      required IESStudent studentUser,
      required StudentRecordSubject subjectRecord,
      required IESAdmin admin}) async {
    try {
      await Tools()
          .repoFirestoreInstance
          .collection("syllabuses")
          .doc(syllabus.administrativeResolution)
          .collection('students')
          .doc(studentUser.id)
          .collection("subjectRecords")
          .doc(subjectRecord.subjectId.toString())
          .update({
        'courseGrade': subjectRecord.courseGrade,
        'courseDate': subjectRecord.courseDateIfAny,
        'finalExamDate': subjectRecord.finalExamDateIfAny,
        'finalExamGrade': subjectRecord.finalExamGrade,
        'adminID': admin.id
      });
    } on Exception {
      throw "Error al actualizar el estudiante";
    }
  }

  @override
  Future<List<StudentRecordSubject>> getStudentRecords(
      {required IESStudent studentUser, required IESAdmin admin}) async {
    try {
      List<StudentRecordSubject> subjectRecords = [];
      await Tools()
          .repoFirestoreInstance
          .collection("students")
          .doc(studentUser.syllabusID)
          .collection('syllabusStudents')
          .doc(studentUser.id)
          .collection("subjectRecords")
          .get()
          .then((qs) async {
        for (var qsDoc in qs.docs) {
          subjectRecords.add(StudentRecordSubject(
              subjectId: int.parse(qsDoc.id),
              finalExamDateIfAny: qsDoc['finalExamDate'] == null
                  ? null
                  : (qsDoc['finalExamDate'] as Timestamp).toDate(),
              finalExamGrade: qsDoc['finalExamGrade'],
              courseDateIfAny: qsDoc['courseDate'] == null
                  ? null
                  : (qsDoc['courseDate'] as Timestamp).toDate(),
              adminID: qsDoc['adminID'],
              courseGrade: qsDoc['courseGrade']));
        }
        subjectRecords.sort((a, b) => a.subjectId - b.subjectId);
      });

      return subjectRecords;
    } on Exception {
      throw "Error al actualizar el estudiante";
    }
  }

  @override
  Future<IESStudent> addStudent(
      {required Syllabus syllabus,
      required IESAdmin admin,
      required String firstName,
      required String lastName,
      required int dni,
      required int book,
      required int page}) async {
    var iesUserDoc = await Tools()
        .repoFirestoreInstance
        .collection('iesUsers')
        .where('dni', isEqualTo: dni)
        .get();

    DocumentReference docRef;
    if (iesUserDoc.docs.isNotEmpty) {
      // Si existe el documento en iesUsers, usar el mismo índice
      var existingDoc = iesUserDoc.docs.first;
      docRef = Tools()
          .repoFirestoreInstance
          .collection('students')
          .doc(syllabus.administrativeResolution)
          .collection("syllabusStudents")
          .doc(existingDoc.id);
      await docRef.set({
        'firstName': firstName,
        'lastName': lastName,
        'dni': dni,
        'book': book,
        'page': page
      });
    } else {
      // Si no existe el documento en iesUsers, crear uno nuevo con un índice aleatorio
      docRef = await Tools()
          .repoFirestoreInstance
          .collection('students')
          .doc(syllabus.administrativeResolution)
          .collection("syllabusStudents")
          .add({
        'firstName': firstName,
        'lastName': lastName,
        'dni': dni,
        'book': book,
        'page': page
      });
    }

    IESStudent newIESStudent = IESStudent(
      firstname: firstName,
      surname: lastName,
      id: docRef.id,
      dni: dni,
      book: book,
      page: page,
      syllabusID: syllabus.administrativeResolution,
    );
    newIESStudent.subjectRecords = List.generate(30, (index) => index + 1)
        .map((subjectID) => StudentRecordSubject(
            subjectId: subjectID,
            finalExamDateIfAny: null,
            finalExamGrade: '-',
            courseDateIfAny: null,
            courseGrade: '',
            adminID: admin.id))
        .toList();

    for (var subjectRecord in newIESStudent.subjectRecords) {
      docRef
          .collection('subjectRecords')
          .doc(subjectRecord.subjectId.toString())
          .set({
        'courseGrade': subjectRecord.courseGrade,
        'courseDate': subjectRecord.courseDateIfAny,
        'finalExamDate': subjectRecord.finalExamDateIfAny,
        'finalExamGrade': subjectRecord.finalExamGrade,
        'adminID': admin.id
      });
    }
    return newIESStudent;
  }
}
