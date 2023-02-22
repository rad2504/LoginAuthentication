import 'dart:async';

import 'package:exinitylogin/pages/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class LoginWithMobile extends StatefulWidget {
  const LoginWithMobile({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<LoginWithMobile> createState() => _LoginWithMobileState();
}

class _LoginWithMobileState extends State<LoginWithMobile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String buttonName = "Send";
  int start = 30;
  bool wait = false;
  bool verifyEnable = false;
  var countryPicker = const FlCountryCodePicker();

  CountryCode? countryCode;
  String smsCode = "";
  TextEditingController phone = TextEditingController();
  var code = "";

  @override
  void initState() {
    final favouriteCountries = [
      'IN',
      'CA',
      'US',
      'JP',
    ];
    countryPicker = FlCountryCodePicker(
        favorites: favouriteCountries,
        favoritesIcon: const Icon(
          Icons.star,
          color: Colors.amber,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SIGNUP")),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
        alignment: Alignment.center,
        child: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget() {
    return SingleChildScrollView(
      child: Column(
        key: formKey,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/phone.jpg'),
            height: 100.0,
          ),
          const SizedBox(
            height: 10.0,
          ),

          const Text(
            "PHONE VERIFICATION",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.0),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "We need to register your phone before getting started!",
            style: TextStyle(color: Colors.black, fontSize: 10.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10.0,
          ),

          TextFormField(
            // key: formKey,
            controller: phone,
            obscureText: false,
            validator: (value) {
              if (RegExp(r'^[a-zA-Z]*$').hasMatch(phone.text)) {
                return "Please enter number";
              }
              return null;
            },
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            maxLength: 10,
            decoration: InputDecoration(
                labelText: "Phone Number",
                border: InputBorder.none,
                prefixIcon: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final code = await countryPicker.showPicker(
                                context: context);
                            setState(() {
                              countryCode = code;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                child: countryCode != null
                                    ? countryCode!.flagImage
                                    : null,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  countryCode?.dialCode ?? "+1",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                labelStyle: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: wait
                ? null
                : () async {
                    setState(() {
                      start = 30;
                      wait = true;
                      buttonName = "Resend";
                    });
                    await authClass.verifyPhoneNumber(
                        "${countryCode!.dialCode}${phone.text}",
                        context,
                        setData);
                  },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text(
              buttonName,
              style: TextStyle(
                  color: wait ? Colors.grey : Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          //
          const Text(
            "ENTER CODE TO VERIFY",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.0),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "Please Enter Code To Verify!",
            style: TextStyle(color: Colors.black, fontSize: 10.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10.0,
          ),
          otpField(),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: start == 0
                ? null
                : () async {
                    try {
                      setState(() {
                        verifyEnable = true;
                        authClass.signInWithPhoneNumber(
                            verificationIdFinal, smsCode, context);
                      });
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                  "Please Enter Correct Code",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const LoginWithMobile()),
                                        (route) => false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                backgroundColor: Colors.white,
                              ));
                    }
                  },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text(
              "VERIFY CODE",
              style: TextStyle(
                  color: start == 0 ? Colors.grey : Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          RichText(
              text: TextSpan(
            children: [
              const TextSpan(
                text: "Send OTP again in ",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              TextSpan(
                text: "00:$start",
                style: const TextStyle(fontSize: 16, color: Colors.pinkAccent),
              ),
              const TextSpan(
                text: " sec ",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Colors.grey,
        borderColor: Colors.white,
      ),
      style: const TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  void startTimer() {
    const onSec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onSec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}
