import 'dart:convert';

import 'package:barber_homepro/dataaccess/apiconnector.dart';
import 'package:barber_homepro/models/login_model.dart';
import 'package:barber_homepro/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final cellNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(fit: StackFit.expand, children: <Widget>[
          SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                  child: Column(children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Create an Account',
                              style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(45),
                                fontFamily: 'Poppins-Bold',
                                letterSpacing: .6,
                              )),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          TextField(
                              controller: firstNameController,
                              decoration: const InputDecoration(
                                labelText: 'First Name',
                              ),
                              keyboardType: TextInputType.text),
                          const SizedBox(height: 16.0),
                          TextField(
                              controller: lastNameController,
                              decoration: const InputDecoration(
                                labelText: 'Last Name',
                              ),
                              keyboardType: TextInputType.text),
                          const SizedBox(height: 16.0),
                          TextField(
                              controller: cellNumberController,
                              decoration: const InputDecoration(
                                  labelText: 'Cell Phone Number',
                                  helperText: 'Optional'),
                              keyboardType: TextInputType.phone),
                          const SizedBox(height: 16.0),
                          TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email Address',
                              ),
                              keyboardType: TextInputType.emailAddress),
                          const SizedBox(height: 16.0),
                          TextField(
                              controller: confirmEmailController,
                              decoration: const InputDecoration(
                                labelText: 'Confirm Email Address',
                              ),
                              keyboardType: TextInputType.emailAddress),
                          const SizedBox(height: 16.0),
                          TextField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          const SizedBox(height: 16.0),
                          TextField(
                            controller: confirmPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: _agreedToTOS,
                                  onChanged: _setAgreedToTOS,
                                ),
                                GestureDetector(
                                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                                  child: const Text(
                                    'I agree to the Ts&Cs',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              const Spacer(),
                              OutlineButton(
                                highlightedBorderColor: Colors.black,
                                onPressed: _submittable() ? _submit : null,
                                child: const Text('Register'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ])))
        ]));
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    _formKey.currentState.validate();
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String confirmEmail = confirmEmailController.text;
    String password = passwordController.text;
    String passwordConfirm = confirmPasswordController.text;
    String cellNumber = cellNumberController.text;

    String errorMsg = "";

    if (firstName.trim() == '') {
      errorMsg = errorMsg + "First Name\n";
    }

    if (lastName.trim() == '') {
      errorMsg = errorMsg + "Last Name\n";
    }

    if (email.trim() == '') {
      errorMsg = errorMsg + "Email Address\n";
    }

    if (confirmEmail.trim() == '') {
      errorMsg = errorMsg + "Confirm Email Address\n";
    }

    if (password.trim() == '') {
      errorMsg = errorMsg + "Password\n";
    }

    if (passwordConfirm.trim() == '') {
      errorMsg = errorMsg + "Confirm Password\n";
    }

    if (confirmEmail.trim() != '' &&
        email.trim() != '' &&
        confirmEmail.trim() != email.trim()) {
      errorMsg = errorMsg + "Email Address doesn't match\n";
    }

    if (passwordConfirm.trim() != '' &&
        password.trim() != '' &&
        passwordConfirm.trim() != password.trim()) {
      errorMsg = errorMsg + "Password doesn't match\n";
    }

    if (errorMsg != '') {
      String msg = "Please check the following : -\n\n" + errorMsg;

      showDialog<void>(
        context: this.context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(msg),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {

      RegistrationClass obj = new RegistrationClass();
      obj.firstName = firstName;
      obj.lastName = lastName;
      obj.cellNumber = cellNumber;
      obj.email = email;
      obj.password = password;

      _register("register/", obj);

    }
  }

  void _register(String operation, RegistrationClass model) {
    String jsonBody = model.toString();
    ApiConnector apiConnector = new ApiConnector(operation, jsonBody);
    apiConnector.postData().then((value) async {
      LoginResponse response = LoginResponse.fromJson(json.decode(value));
      if (response.success == 1) {
        SharedPreferences preference = await SharedPreferences.getInstance();
        preference.setBool('LoggedIn', true);
        preference.setString('UserId', response.userId);
        preference.setString('FullName', response.fullName);
        preference.setString('Email', response.email);
        preference.setString('CellNumber', response.cellNumber);
        preference.setString('ProfileUrl', response.profileUrl);
        preference.setString('Token', response.token);
        
        Navigator.push(
          this.context,
          MaterialPageRoute(builder: (context) => HomeClass()),
        );
      } else {
        showDialog<void>(
          context: this.context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Register'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(response.message),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
