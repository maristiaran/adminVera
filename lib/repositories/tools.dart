import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mini_vera/repositories/students_firebase_adapter.dart';
import 'package:mini_vera/repositories/syllabus_memory_adapter.dart';
import 'package:mini_vera/repositories/users_firebase_adapter.dart';
import 'package:operation_cubit/tools_and_settings.dart';

enum FrutalityLanguages { en, sp }

class Tools extends ToolsAndSettings {
  static final Tools _singleton = Tools._internal();

  // late Dio repoDio;
  late FirebaseAuth repoFirestoreAuthInstance;
  late FirebaseFirestore repoFirestoreInstance;
  late GoogleSignIn repoGoogleSignIn;
  // late FacebookAuth repoFacebookAuth;
  // late FirebaseMessaging repoMessaging;
  late FirebaseStorage firebaseStorage;
  late UsersRepositoryFirestoreAdapter repoUsersRepository;
  late SyllabusesRepositoryMemoryAdapter repoSyllabuses;
  late StudentsFirebaseAdapter repoStudents;
  // late Client repoHttpClient;
  // late DateTimeHttpAdapter repoDatetimeRepository;
  // late PowersMemoryAdapter repoPowersRepository;

  factory Tools() {
    return _singleton;
  }
  Tools._internal();

  @override
  Future<void> initRepositories() async {
    // repoHttpClient = http.Client();
    // repoDio = Dio(BaseOptions(headers: {"Content-Type": "application/json"}));

    // repoDatetimeRepository = DateTimeHttpAdapter();
    // await repoDatetimeRepository.init();
    repoFirestoreAuthInstance = FirebaseAuth.instance;
    repoFirestoreInstance = FirebaseFirestore.instance;
    repoGoogleSignIn = GoogleSignIn();
    // repoFacebookAuth = FacebookAuth.instance;

    repoUsersRepository = UsersRepositoryFirestoreAdapter();
    repoSyllabuses = SyllabusesRepositoryMemoryAdapter();
    repoSyllabuses.initRepositoryCaches();
    repoStudents = StudentsFirebaseAdapter();
    firebaseStorage = FirebaseStorage.instance;

    // repoPowersRepository = PowersMemoryAdapter();
  }
}
