import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:mini_vera/mini_vera_app.dart';
import 'package:mini_vera/presentation/default_theme.dart';
import 'package:mini_vera/repositories/tools.dart';
import 'package:operation_cubit/operations_app.dart';

void main() async {
  runApp(OperationsApp(
      system: miniVera,
      startingView: Container(color: Colors.green),
      themeBuilder: defaultTheme));
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDP1rLX6ZQosv4_6RDzNvU9F4YA9Z9vUPc",
    authDomain: "sistema-ies-50b4b.firebaseapp.com",
    projectId: "sistema-ies-50b4b",
    storageBucket: "sistema-ies-50b4b.firebasestorage.app",
    messagingSenderId: "186026249077",
    appId: "1:186026249077:web:83ae7f12bfad3940ada13c",
  ));

  var toolsAndSettings = Tools();

  await toolsAndSettings.initialize();
  miniVera.init();
}
