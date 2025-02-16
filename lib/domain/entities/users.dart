class IESUser {
  String firstname;
  String surname;
  String email;
  String id;
  final DateTime birthdate;
  final int dni;
  List<IESUserRole> roles;
  IESUserRole currentRole;

  IESUser({
    required this.firstname,
    required this.surname,
    required this.email,
    required this.id,
    required this.birthdate,
    required this.dni,
    required this.roles,
  }) : currentRole = roles.isNotEmpty
            ? roles[0]
            : throw ArgumentError('Roles no puede estar vacío');

  void changeCurrentRole(IESUserRole newRole) {
    if (roles.contains(newRole)) {
      currentRole = newRole;
    } else {
      throw ArgumentError('El rol no se encuentra en la lista de roles.');
    }
  }
}

enum IESRolType { student, admin }

abstract class IESRoleForSearch {
  IESRolType type;
  String syllabusID;
  IESRoleForSearch({required this.type, required this.syllabusID});
}

class IESStudentRoleForSearch extends IESRoleForSearch {
  IESStudentRoleForSearch({required super.syllabusID})
      : super(type: IESRolType.student);
}

class IESAdminRoleForSearch extends IESRoleForSearch {
  IESAdminRoleForSearch({required super.syllabusID})
      : super(type: IESRolType.admin);
}

abstract class IESUserRole {
  String syllabusID;
  String id;

  IESUserRole({required this.syllabusID, required this.id});
}

class IESStudentRole extends IESUserRole {
  int book;
  int page;

  IESStudentRole({
    required super.syllabusID,
    required this.book,
    required this.page,
    required super.id,
  });
}

class IESAdminRole extends IESUserRole {
  IESAdminRole({required super.syllabusID, required super.id});
}
