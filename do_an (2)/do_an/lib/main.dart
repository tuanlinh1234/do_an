import 'package:do_an/prefer.dart';
import 'package:do_an/screen/google_login.dart';
import 'package:do_an/screen/play.dart';
import 'package:do_an/screen/start.dart';
import 'package:flutter/material.dart';
import 'screen/login.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();
  await Prefer.InitPref();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_){
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Prefer.getMail() != null ? Start(): LogIn(),
    );
  }
}