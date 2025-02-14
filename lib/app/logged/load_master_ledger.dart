import 'package:mini_vera/app/logged/logged.dart';
import 'package:mini_vera/domain/entities/students.dart';
import 'package:mini_vera/domain/entities/syllabus.dart';
import 'package:mini_vera/domain/entities/users.dart';
import 'package:mini_vera/repositories/tools.dart';
import 'package:operation_cubit/operation.dart';
import 'package:operation_cubit/operation_cubit.dart';

class LedgerStudentRecordSubject extends StudentRecordSubject {
  String subjectName;
  LedgerStudentRecordSubject(
      {required super.subjectId,
      required this.subjectName,
      required super.finalExamDateIfAny,
      required super.finalExamGrade,
      required super.courseDateIfAny,
      required super.admin,
      required super.courseGrade});

  @override
  String toString() {
    return "subjectId $subjectId subjectName, $subjectName finalExamDateIfAny, $finalExamDateIfAny finalExamGrade, $finalExamGrade courseDateIfAny, $courseDateIfAny admin, $admin courseGrade $courseGrade";
  }
}

enum LoadMasterLedgerExits { exit }

class LoadMasterLedgerBaseState extends OperationState {
  List<IESStudentUser> searchedStudents;
  IESStudentUser? selectedStudentIfAny;
  int selectedYear;
  bool addingOrEditingStudent;
  List<LedgerStudentRecordSubject> currentSubjectRecords;
  int? selectedSubjectRecordIDIfAny;
  String selectedSubjectAdvice = '';
  Syllabus syllabus;

  LoadMasterLedgerBaseState(
      {this.selectedSubjectRecordIDIfAny,
      this.selectedSubjectAdvice = '',
      required this.searchedStudents,
      required this.selectedStudentIfAny,
      required this.selectedYear,
      required this.currentSubjectRecords,
      required this.addingOrEditingStudent,
      required this.syllabus});

  @override
  bool operator ==(Object other) =>
      other is LoadMasterLedgerBaseState &&
      other.selectedSubjectRecordIDIfAny == selectedSubjectRecordIDIfAny &&
      other.searchedStudents.length == searchedStudents.length &&
      other.selectedStudentIfAny == selectedStudentIfAny &&
      other.selectedYear == selectedYear &&
      other.addingOrEditingStudent == addingOrEditingStudent &&
      other.currentSubjectRecords.isNotEmpty &&
      currentSubjectRecords.isNotEmpty &&
      (other.currentSubjectRecords.first == currentSubjectRecords.first);

  @override
  int get hashCode => searchedStudents.hashCode;
}

class LoadMasterLedger extends ChildOperation {
  bool addingStudent = false;
  bool editingStudent = false;
  late LoadMasterLedgerBaseState lastLoadMasterLedgerBaseState;
  late IESAdminUser adminUserLogged;
  late Syllabus currentSyllabus;
  int selectedYear = 1;
  LoadMasterLedger({
    super.children,
    required super.blocProviderBuilder,
  });

  List<LedgerStudentRecordSubject> _studentRecordsToYearLedgerRecords(
      {required Syllabus syllabus,
      required year,
      required List<StudentRecordSubject> studentRecords}) {
    List<LedgerStudentRecordSubject> ledgerRecords = [];
    for (int index in currentSyllabus.subjectIDsOfYear(year)) {
      var aStudentRecord = studentRecords[index - 1];

      ledgerRecords.add(LedgerStudentRecordSubject(
          subjectId: aStudentRecord.subjectId,
          subjectName: syllabus.subjects[index - 1].name,
          finalExamDateIfAny: aStudentRecord.finalExamDateIfAny,
          finalExamGrade: aStudentRecord.finalExamGrade,
          courseDateIfAny: aStudentRecord.courseDateIfAny,
          admin: adminUserLogged,
          courseGrade: aStudentRecord.courseGrade));
    }
    return ledgerRecords;
  }

  Future<void> changeCurrentSyllabusID(String newValue) async {
    adminUserLogged.changeCurrentSyllabusID(newValue);
    Syllabus? newSyllabus =
        await _getSyllabusByAdministrativeResolutionifAny(newValue);
    if (newSyllabus != null) {
      currentSyllabus = newSyllabus;
      // Aquí puedes agregar cualquier lógica adicional que necesites después de cambiar el syllabusID
    } else {
      emitError("No se pudo encontrar el nuevo plan de estudios");
    }
  }

  exit() {
    exitOperation(OCResult.success(statusOnExit: LoadMasterLedgerExits.exit));
  }

  searchStudent(String searchString) async {
    String lastName1 = searchString.split(' ')[0].trim();
    String lastName =
        "${lastName1[0].toUpperCase()}${lastName1.substring(1).toLowerCase()}";

    var students = await Tools()
        .repoStudents
        .searchStudentsByName(lastName: lastName, syllabus: currentSyllabus);

    lastLoadMasterLedgerBaseState = LoadMasterLedgerBaseState(
        searchedStudents: students,
        selectedStudentIfAny: null,
        selectedYear: selectedYear,
        currentSubjectRecords: [],
        addingOrEditingStudent: addingOrEditingStudent,
        syllabus: currentSyllabus);

    emit(lastLoadMasterLedgerBaseState);
  }

  addStudent(
      {required String firstNameWithoutFormat,
      required String lastNameWithoutFormat,
      required int dni,
      required int book,
      required int page}) async {
    String firstName = firstNameWithoutFormat
        .split(' ') // Divide la cadena en palabras
        .map((palabra) => palabra.isNotEmpty // Evita errores con cadenas vacías
            ? '${palabra[0].toUpperCase()}${palabra.substring(1).toLowerCase()}'
            : '') // Convierte la primera letra en mayúscula y las demás en minúscula
        .join(' ');

    String lastName = lastNameWithoutFormat
        .split(' ') // Divide la cadena en palabras
        .map((palabra) => palabra.isNotEmpty // Evita errores con cadenas vacías
            ? '${palabra[0].toUpperCase()}${palabra.substring(1).toLowerCase()}'
            : '') // Convierte la primera letra en mayúscula y las demás en minúscula
        .join(' ');

    try {
      IESStudentUser newStudent = await Tools().repoStudents.addStudent(
          admin: adminUserLogged,
          syllabus: currentSyllabus,
          firstName: firstName,
          lastName: lastName,
          dni: dni,
          book: book,
          page: page);

      emitConfirmation("Estudiante agregado $lastName, $firstName");
      addingStudent = false;

      lastLoadMasterLedgerBaseState = LoadMasterLedgerBaseState(
          searchedStudents: [],
          selectedStudentIfAny: newStudent,
          selectedYear: selectedYear,
          currentSubjectRecords: _studentRecordsToYearLedgerRecords(
            studentRecords: newStudent.subjectRecords,
            syllabus: currentSyllabus,
            year: selectedYear,
          ),
          addingOrEditingStudent: addingOrEditingStudent,
          syllabus: currentSyllabus);

      emit(lastLoadMasterLedgerBaseState);
    } on Exception {
      emitError("No se pudo guardar el estudiante");
    }
  }

  selectStudent(IESStudentUser selectedStudent) async {
    try {
      var selSubjectRecords = await Tools().repoStudents.getStudentRecords(
          syllabus: currentSyllabus,
          student: selectedStudent,
          admin: adminUserLogged);

      selectedStudent.subjectRecords = selSubjectRecords;
      lastLoadMasterLedgerBaseState = LoadMasterLedgerBaseState(
          searchedStudents: [],
          selectedStudentIfAny: selectedStudent,
          selectedYear: selectedYear,
          currentSubjectRecords: _studentRecordsToYearLedgerRecords(
            studentRecords: selSubjectRecords,
            syllabus: currentSyllabus,
            year: selectedYear,
          ),
          addingOrEditingStudent: false,
          syllabus: currentSyllabus);
      emit(lastLoadMasterLedgerBaseState);
    } on Exception {
      emitError("No es posible cargar registros del estudiante");
    }
  }

  selectYear(int year) {
    if (lastLoadMasterLedgerBaseState.selectedStudentIfAny != null) {
      selectedYear = year;
      lastLoadMasterLedgerBaseState = LoadMasterLedgerBaseState(
          searchedStudents: [],
          selectedStudentIfAny:
              lastLoadMasterLedgerBaseState.selectedStudentIfAny,
          selectedYear: selectedYear,
          currentSubjectRecords: _studentRecordsToYearLedgerRecords(
            studentRecords: lastLoadMasterLedgerBaseState
                .selectedStudentIfAny!.subjectRecords,
            syllabus: currentSyllabus,
            year: selectedYear,
          ),
          addingOrEditingStudent: addingOrEditingStudent,
          syllabus: currentSyllabus);

      emit(lastLoadMasterLedgerBaseState);
    }
  }

  selectSubjectRecordID(int subjectID) {
    addingStudent = false;
    int? newSubjectID =
        lastLoadMasterLedgerBaseState.selectedSubjectRecordIDIfAny == subjectID
            ? null
            : subjectID;
    String newAdvice = '';
    if (newSubjectID != null) {
      var requiredFinalExamIDs = currentSyllabus
          .getSubjectIfAnyByID(newSubjectID)!
          .examNeededForExamination
          .map((s) => s.id);

      var finalExamMissing = lastLoadMasterLedgerBaseState
          .selectedStudentIfAny!.subjectRecords
          .where((sr) =>
              requiredFinalExamIDs.contains(sr.subjectId) &&
              !['6', '7', '8', '9', '10'].contains(sr.finalExamGrade))
          .toList();

      List<String> missingStudentRecords = [];
      if (finalExamMissing.isEmpty) {
        newAdvice = "Esta en condiciones de rendir";
      } else {
        for (StudentRecordSubject sr in finalExamMissing) {
          if (!['6', '7', '8', '9', '10'].contains(sr.finalExamGrade)) {
            missingStudentRecords.add(
                "${sr.subjectId}. - ${currentSyllabus.getSubjectIfAnyByID(sr.subjectId)!.name}");
          }
        }
        newAdvice =
            "Para poder rendir, le faltan las siguientes materias: ${missingStudentRecords.join(',')}";
      }
    }

    lastLoadMasterLedgerBaseState = LoadMasterLedgerBaseState(
        selectedSubjectRecordIDIfAny: newSubjectID,
        selectedSubjectAdvice: newAdvice,
        searchedStudents: lastLoadMasterLedgerBaseState.searchedStudents,
        selectedStudentIfAny:
            lastLoadMasterLedgerBaseState.selectedStudentIfAny,
        selectedYear: selectedYear,
        currentSubjectRecords:
            lastLoadMasterLedgerBaseState.currentSubjectRecords,
        addingOrEditingStudent: false,
        syllabus: currentSyllabus);

    emit(lastLoadMasterLedgerBaseState);
  }

  cancelEditingStudent() {
    addingStudent = false;
    lastLoadMasterLedgerBaseState = LoadMasterLedgerBaseState(
        searchedStudents: [],
        selectedStudentIfAny: null,
        selectedYear: selectedYear,
        currentSubjectRecords: [],
        addingOrEditingStudent: addingOrEditingStudent,
        syllabus: currentSyllabus);

    emit(lastLoadMasterLedgerBaseState);
  }

  saveSubjectRecordEntry(Map<String, dynamic> record) {
    try {
      Tools().repoStudents.updateSubjectRecord(
          syllabus: currentSyllabus,
          student: lastLoadMasterLedgerBaseState.selectedStudentIfAny!,
          subjectRecord: StudentRecordSubject(
              subjectId: record['id'],
              finalExamDateIfAny: record['finalExamDate'],
              finalExamGrade: record['finalExamGrade'],
              courseDateIfAny: record['courseDate'],
              admin: adminUserLogged,
              courseGrade: record['courseGrade']),
          admin: adminUserLogged);

      lastLoadMasterLedgerBaseState = LoadMasterLedgerBaseState(
          searchedStudents: [],
          selectedStudentIfAny:
              lastLoadMasterLedgerBaseState.selectedStudentIfAny,
          selectedYear: lastLoadMasterLedgerBaseState.selectedYear,
          currentSubjectRecords:
              lastLoadMasterLedgerBaseState.currentSubjectRecords,
          addingOrEditingStudent: addingOrEditingStudent,
          syllabus: currentSyllabus);
      lastLoadMasterLedgerBaseState
              .selectedStudentIfAny!.subjectRecords[record['id'] - 1] =
          StudentRecordSubject(
              subjectId: record['id'],
              finalExamDateIfAny: record['finalExamDate'],
              finalExamGrade: record['finalExamGrade'],
              courseDateIfAny: record['courseDate'],
              admin: adminUserLogged,
              courseGrade: record['courseGrade']);
      emitConfirmation("Registro del estudiante actualizado con éxito");
      emit(lastLoadMasterLedgerBaseState);
    } on Exception {
      emitError("No se pudo actualizar el regisrto del estudiante");
    }
  }

  editStudent() {
    addingStudent = true;
    lastLoadMasterLedgerBaseState = LoadMasterLedgerBaseState(
        searchedStudents: [],
        selectedStudentIfAny: null,
        selectedYear: selectedYear,
        currentSubjectRecords: [],
        addingOrEditingStudent: addingOrEditingStudent,
        syllabus: currentSyllabus);

    emit(lastLoadMasterLedgerBaseState);
  }

  updateStudent() {}

  updateSubjectRecord() {}

  @override
  Future<(ChildOperation, Map<Enum, dynamic>)?> initialize(
      {required Operation parent, required Map<Enum, dynamic>? args}) async {
    adminUserLogged = (parent as Logged).userLogged;
    Syllabus? syllabusFoundIfAny =
        await _getSyllabusByAdministrativeResolutionifAny(
            adminUserLogged.currentSyllabusID);

    if (syllabusFoundIfAny == null) {
      throw "No se puede encontrar el Plan de estudios";
    } else {
      currentSyllabus = syllabusFoundIfAny;

      lastLoadMasterLedgerBaseState = LoadMasterLedgerBaseState(
          searchedStudents: [],
          selectedStudentIfAny: null,
          selectedYear: selectedYear,
          currentSubjectRecords: [],
          addingOrEditingStudent: addingOrEditingStudent,
          syllabus: currentSyllabus);

      emit(lastLoadMasterLedgerBaseState);
    }

    return null;
  }

  bool get addingOrEditingStudent => addingStudent || editingStudent;

  Future<Syllabus?> _getSyllabusByAdministrativeResolutionifAny(
      String administrativeResolution) async {
    Syllabus? syllabusFoundIfAny;
    (await Tools().repoSyllabuses.getSyllabusByAdministrativeResolution(
            administrativeResolution: administrativeResolution))
        .fold((failure) => syllabusFoundIfAny = null,
            (currentSyllabus) => syllabusFoundIfAny = currentSyllabus);
    return syllabusFoundIfAny;
  }
}
