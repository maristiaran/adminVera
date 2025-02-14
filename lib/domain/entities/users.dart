class IESAdminUser {
  String firstName;
  String lastName;
  List<String> syllabusIDs;
  String currentSyllabusID;
  String email;
  String id;
  final DateTime birthdate;
  final int dni;

  IESAdminUser({
    required this.firstName,
    required this.lastName,
    required this.syllabusIDs,
    required this.id,
    required this.email,
    required this.birthdate,
    required this.dni,
  }) : currentSyllabusID = syllabusIDs.isNotEmpty ? syllabusIDs[0] : '';

  void changeCurrentSyllabusID(String newSyllabusID) {
    if (syllabusIDs.contains(newSyllabusID)) {
      currentSyllabusID = newSyllabusID;
    } else {
      throw ArgumentError('Syllabus ID no encontrado en la lista.');
    }
  }
}
