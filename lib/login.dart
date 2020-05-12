import 'dart:convert';

import 'package:barber_homepro/dataaccess/apiconnector.dart';
import 'package:barber_homepro/models/login_model.dart';
import 'package:barber_homepro/pages/home.dart';
import 'package:barber_homepro/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget/SocialIcon.dart';

class LoginClass extends StatefulWidget {
  @override
  _LoginClassState createState() => _LoginClassState();
}

class _LoginClassState extends State<LoginClass> {
  bool _isSelected = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  

  void _login(String operation, LoginModel model) {
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
              title: Text('Login'),
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

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: Colors.black),
        ),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);

    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
                child: Padding(
                    padding:
                        EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/image/logo.png',
                              width: ScreenUtil.getInstance().setWidth(110),
                              height: ScreenUtil.getInstance().setHeight(110),
                            ),
                            Text('Vieta',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Bold',
                                  fontSize: ScreenUtil.getInstance().setSp(46),
                                  letterSpacing: .6,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(180),
                        ),
                        Container(
                            width: double.infinity,
                            height: ScreenUtil.getInstance().setHeight(500),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 15.0),
                                  blurRadius: 15.0,
                                ),
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, -10.0),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, top: 16.0, right: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Login',
                                      style: TextStyle(
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(45),
                                        fontFamily: 'Poppins-Bold',
                                        letterSpacing: .6,
                                      )),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Text('Username',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(26),
                                      )),
                                  TextField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                        hintText: 'username',
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0)),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(30),
                                  ),
                                  Text('Password',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(26),
                                      )),
                                  TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: 'password',
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0)),
                                  ),
                                  SizedBox(
                                    height:
                                        ScreenUtil.getInstance().setHeight(35),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text('Forgot Password?',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: ScreenUtil.getInstance()
                                                .setSp(28),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(35),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      ScreenUtil.getInstance().setWidth(12.0),
                                ),
                                GestureDetector(
                                  onTap: _radio,
                                  child: radioButton(_isSelected),
                                ),
                                SizedBox(
                                  width: ScreenUtil.getInstance().setWidth(8.0),
                                ),
                                Text('Remember me',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Poppins-Medium',
                                    )),
                              ],
                            ),
                            InkWell(
                              child: Container(
                                  width: ScreenUtil.getInstance().setWidth(300),
                                  height:
                                      ScreenUtil.getInstance().setHeight(80),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xFF17ead9),
                                      Color(0xFF6078ea)
                                    ]),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xFF6078ea).withOpacity(.3),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0,
                                      )
                                    ],
                                  ),
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          onTap: () {
                                            var user = usernameController.text;
                                            var pass = passwordController.text;

                                            if (user == "" || pass == "") {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        "Please enter username and password"),
                                                  );
                                                },
                                              );
                                            } else {
                                              LoginModel model =
                                                  new LoginModel();
                                              model.username = user;
                                              model.password = pass;
                                              _login("login/", model);
                                            }
                                          },
                                          child: Center(
                                              child: Text('SIGNIN',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          'Poppins-Bold',
                                                      fontSize: 14.0,
                                                      letterSpacing: 1.0)))))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            horizontalLine(),
                            Text('Social Login',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins-Medium',
                                )),
                            horizontalLine(),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SocialIcon(
                              colors: [
                                Color(0xFF102397),
                                Color(0xFF187adf),
                                Color(0xFF00eaf8),
                              ],
                              icondata: CustomIcons.facebook,
                              onPressed: () {},
                            ),
                            SocialIcon(
                              colors: [
                                Color(0xFFff4f38),
                                Color(0xFFff355d),
                              ],
                              icondata: CustomIcons.googlePlus,
                              onPressed: () {},
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(30),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'New User? ',
                              style: TextStyle(fontFamily: 'Poppins-Medium'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  this.context,
                                  MaterialPageRoute(builder: (context) => RegisterForm()),
                                );
                              },
                              child: Text('SignUp',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Bold',
                                    color: Color(0xFF5d74e3),
                                  )),
                            )
                          ],
                        )
                      ],
                    ))),
          ],
        ));
  }
}

class CustomIcons {
  static const IconData twitter = IconData(0xe900, fontFamily: 'CustomIcons');
  static const IconData facebook = IconData(0xe901, fontFamily: 'CustomIcons');
  static const IconData googlePlus =
      IconData(0xe902, fontFamily: 'CustomIcons');
  static const IconData linkedin = IconData(0xe903, fontFamily: 'CustomIcons');
}
