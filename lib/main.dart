import 'package:exinitylogin/pages/Auth_Service.dart';
import 'package:exinitylogin/pages/Sign_Up.dart';
import 'package:exinitylogin/pages/fourth_file.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = CommonSignUpPage(
    emailFromSignIn: '',
    passwordFromSignIn: '',
    firstNameFromSignIn: '',
    lastNameFromSignIn: '',
  );
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = fourth(
          firstName: '',
          lastName: '',
          email: '',
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: currentPage);
  }
}
