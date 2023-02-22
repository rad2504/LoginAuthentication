import 'package:exinitylogin/pages/SignUpWithEmail.dart';
import 'package:exinitylogin/pages/fourth_file.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'Auth_Service.dart';
import 'login_with_mobile.dart';

class CommonSignUpPage extends StatefulWidget {
  String firstNameFromSignIn = "";
  String lastNameFromSignIn = "";
  String emailFromSignIn = "";
  String passwordFromSignIn = "";

  CommonSignUpPage(
      {Key? key,
      required this.emailFromSignIn,
      required this.passwordFromSignIn,
      required this.firstNameFromSignIn,
      required this.lastNameFromSignIn})
      : super(key: key);

  @override
  _CommonSignUpPageState createState() => _CommonSignUpPageState();
}

class _CommonSignUpPageState extends State<CommonSignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  await authClass.googleSignIn(context);
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 60,
                  child: Card(
                    color: Colors.black,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/gmail.png",
                          height: 25,
                          width: 25,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Continue with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const LoginWithMobile()),
                      (route) => false);
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 60,
                  child: Card(
                    color: Colors.black,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/phoneIcon.png",
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Continue with Mobile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Or",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(
                height: 18,
              ),
              textItem("Email....", _emailController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Password...", _pwdController, true),
              const SizedBox(
                height: 40,
              ),
              colorButton(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "If you don't have an Account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const SignUpWithEmail()),
                          (route) => false);
                    },
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton() {
    return InkWell(
      onTap: (_emailController.text.isEmpty || _pwdController.text.isEmpty)
          ? null
          : () async {
              setState(() {
                circular = true;
              });
              try {
                // firebase_auth.UserCredential userCredential =
                // await firebaseAuth.createUserWithEmailAndPassword(
                //     email: _emailController.text, password: _pwdController.text);
                // print(userCredential.user?.email);
                // setState(() {
                //   circular = false;
                // });
                if (widget.emailFromSignIn != _emailController.text) {
                  setState(() {
                    circular = false;
                  });
                  const snackBar =
                      SnackBar(content: Text("Please Enter Correct Id"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (widget.passwordFromSignIn != _pwdController.text) {
                  setState(() {
                    circular = false;
                  });
                  const snackBar =
                      SnackBar(content: Text("Please Enter Correct PassWord"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (widget.emailFromSignIn == _emailController.text &&
                    widget.passwordFromSignIn == _pwdController.text) {
                  setState(() {
                    circular = false;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => fourth(
                                  email: widget.emailFromSignIn,
                                  firstName: widget.firstNameFromSignIn,
                                  lastName: widget.lastNameFromSignIn,
                                )),
                        (route) => false);
                  });
                  const snackBar = SnackBar(content: Text("Logged In"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } catch (e) {
                final snackBar = SnackBar(content: Text(e.toString()));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() {
                  circular = false;
                });
              }
            },
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _emailController.text.isEmpty || _pwdController.text.isEmpty
              ? Colors.grey[500]
              : Colors.deepOrangeAccent,
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : const Text(
                  "LogIn",
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
    return SizedBox(
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
