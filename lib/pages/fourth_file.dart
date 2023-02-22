import 'package:exinitylogin/pages/Auth_Service.dart';
import 'package:exinitylogin/pages/Sign_Up.dart';
import 'package:flutter/material.dart';

class fourth extends StatelessWidget {
  String firstName = "";
  String lastName = "";
  String email = "";
  AuthClass authClass = AuthClass();

  fourth(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fourth"),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(60.0, 30.0, 0.0, 0.0),
        child: Column(
          children: [
            Text(
              "WELCOME ${firstName.toUpperCase()} ${lastName.toUpperCase()}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Your email is: $email"),
            const SizedBox(
              height: 420,
              width: 200,
            ),
            ElevatedButton(
              onPressed: () async {
                if (await authClass.getToken() != null) {
                  await authClass.signOut(context: context);
                }

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => CommonSignUpPage(
                              emailFromSignIn: '',
                              passwordFromSignIn: '',
                              firstNameFromSignIn: '',
                              lastNameFromSignIn: '',
                            )),
                    (route) => false);
              },
              child: const Text("LogOut"),
            ),
          ],
        ),
      ),
    );
  }
}
