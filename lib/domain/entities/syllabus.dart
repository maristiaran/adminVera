class Syllabus {
  final String name;
  final String administrativeResolution;
  final bool isATeachersSyllabus;
  List<Subject> subjects = [];

  Syllabus(
      {required this.name,
      required this.administrativeResolution,
      required this.isATeachersSyllabus});

  addSubject(Subject newSubject) {
    subjects.add(newSubject);
  }

  @override
  String toString() {
    return "$name ($administrativeResolution)";
  }

  Subject? getSubjectIfAnyByID(int id) {
    if (subjects.length >= id) {
      return subjects[id - 1];
    } else {
      return null;
    }
  }

  int subjectCount() {
    return subjects.length;
  }

  List<Subject> subjectsOfYear(int year) {
    return subjects.where((subject) => subject.courseYear == year).toList();
  }

  List<int> subjectIDsOfYear(int year) {
    return subjects
        .where((subject) => subject.courseYear == year)
        .map((s) => s.id)
        .toList();
  }
}

enum SubjectType { module, workshop, professionalPractice, seminary }

enum SubjectDuration { allYear, firstQuarter, secondQuarter }

class Subject {
  //id format: id_syllabus - order_number.For example: 501-DGE-19-02
  final int id;
  final int courseYear;
  final String name;
  final List<SubjectType> subjectType;
  final SubjectDuration subjectDuration;
  final int hoursPerWeek;
  List<Subject> coursesNeededForCoursing = [];
  List<Subject> examNeededForExamination = [];

  Subject(
      {required this.id,
      required this.name,
      required this.subjectType,
      required this.subjectDuration,
      required this.hoursPerWeek,
      required this.courseYear});

  // String get syllabusID => id.substring(0, id.length - 3);
  // int get orderNumber => int.parse(id.substring(id.length - 3));
// }

// class Subject {
//   final int id;
//   final int courseYear;
//   final String name;
//   final List<SubjectType> subjectType;
//   final SubjectDuration subjectDuration;
//   final int hoursPerWeek;
//   List<Subject> coursesNeededForCoursing = [];
//   List<Subject> examNeededForExamination = [];

//   Subject(
//       {required this.id,
//       required this.name,
//       required this.subjectType,
//       required this.subjectDuration,
//       required this.hoursPerWeek,
//       required this.courseYear});

  @override
  String toString() {
    return name;
  }

  addCourseNeededForCoursing(Subject subjectCourse) {
    coursesNeededForCoursing.add(subjectCourse);
  }

  addExamNeededForExamination(Subject subjectExam) {
    examNeededForExamination.add(subjectExam);
  }
}
