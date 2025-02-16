class IESAdmin {
  String firstname;
  String surname;
  String id;
  String email;
  final int dni;
  String currentSyllabusID;
  List<String> syllabusIDs;
  IESAdmin({
    required this.firstname,
    required this.surname,
    required this.id,
    required this.email,
    required this.dni,
    required this.currentSyllabusID,
    this.syllabusIDs = const [],
  });

  changeCurrentSyllabusID(newValue) {
    if (syllabusIDs.contains(newValue)) {
      currentSyllabusID = newValue;
    }
  }
}
