import 'package:either_dart/either.dart';
import 'package:mini_vera/domain/entities/syllabus.dart';
import 'package:mini_vera/domain/utils/responses.dart';

abstract class SyllabusesRepositoryPort {
  // Future<Either<Failure, List<Syllabus>>> getActiveSyllabuses();
  Future<Either<Failure, Syllabus>> getSyllabusByAdministrativeResolution(
      {required String administrativeResolution});

  Future<Either<Failure, List<Syllabus>>>
      getSyllabusesByAdministrativeResolution(
          {required List<String> administrativeResolutions});

  List<Syllabus> getAllSyllabuses();
}
