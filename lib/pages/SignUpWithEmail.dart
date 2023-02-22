import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'Sign_Up.dart';

class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({super.key});

  @override
  _SignUpWithEmailState createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _rePwdController = TextEditingController();

  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "CREATE",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              textItem("First Name ", _firstNameController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Last Name", _lastNameController, false),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                width: MediaQuery.of(context).size.width - 70,
                height: 55,
                child: TextFormField(
                  controller: _emailController,
                  obscureText: false,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1.5,
                        color: Colors.amber,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              textItem("Username", _usernameController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Password", _pwdController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Re-Enter Password", _rePwdController, false),
              const SizedBox(
                height: 40,
              ),
              colorButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: (_firstNameController.text.isEmpty ||
              _lastNameController.text.isEmpty ||
              _emailController.text.isEmpty ||
              _usernameController.text.isEmpty ||
              _pwdController.text.isEmpty ||
              _rePwdController.text.isEmpty)
          ? null
          : () async {
              if (!EmailValidator.validate(_emailController.text)) {
                const snackBar =
                    SnackBar(content: Text("Please Enter Proper Email"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (_pwdController.text != _rePwdController.text) {
                const snackBar =
                    SnackBar(content: Text("Please Enter Same PassWord"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (_usernameController.text.length <= 6) {
                const snackBar = SnackBar(
                    content: Text("Username length should be more than 6"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => CommonSignUpPage(
                              firstNameFromSignIn: _firstNameController.text,
                              lastNameFromSignIn: _lastNameController.text,
                              emailFromSignIn: _emailController.text,
                              passwordFromSignIn: _pwdController.text,
                            )),
                    (route) => false);
              }
            },
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (_firstNameController.text.isEmpty ||
                    _lastNameController.text.isEmpty ||
                    _emailController.text.isEmpty ||
                    _usernameController.text.isEmpty ||
                    _pwdController.text.isEmpty ||
                    _rePwdController.text.isEmpty)
                ? Colors.grey[500]
                : Colors.deepOrangeAccent),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }

  Widget textItem(
      String labelText, TextEditingController controller, bool obscureText) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
