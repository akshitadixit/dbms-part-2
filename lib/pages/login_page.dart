import 'package:flutter/material.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/pages/home_page.dart';
import 'package:travel_app/widget/loading.dart';
import 'package:travel_app/services/auth.dart';
import 'package:travel_app/theme.dart';
import 'package:travel_app/widget/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  get kBackgroundColor => null;

  String email = "";
  String Password = "";
  bool loading = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
            child: Image.asset(
              'assets/icon_back.png',
              width: 60,
              height: 60,
            ),
          ),
          Text(
            "Login",
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          Image.asset(
            "assets/icon_three_dots.png",
            width: 60,
            height: 60,
          ),
        ],
      );
    }

    return SafeArea(
      child: loading
          ? Loading()
          : Scaffold(
              backgroundColor: kBackgroundColor,
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 23,
                    right: 23,
                    top: 27,
                    bottom: 100,
                  ),
                  child: Column(
                    children: [
                      header(),
                      SizedBox(height: 100),
                      Text(
                        "Welcome Back!",
                        style: blackTextStyle.copyWith(
                          fontSize: 40,
                          fontWeight: semiBold,
                        ),
                      ),
                      //SizedBox(height: 200),
                      Container(
                        padding: EdgeInsets.only(top: 125, right: 35, left: 35),
                        child: Column(
                          children: [
                            Text(error, style: TextStyle(color: Colors.red)),
                            SizedBox(height: 20),
                            TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onChanged: (val) => email = val,
                            ),
                            SizedBox(height: 20),
                            TextField(
                              obscureText: true, //to give password effect
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onChanged: (val) => Password = val,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Button(
                              width: 243,
                              height: 54,
                              fontSize: 22,
                              content: 'Sign in',
                              onClick: () async {
                                setState(() {
                                  loading = true;
                                });
                                try {
                                  dynamic user =
                                      await _auth.signinwithEmailandpassword(
                                          email, Password);
                                  if (user != null) {
                                    // changes here are to facilitate user id to respective pages/modules
                                    Home.user = user;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  }
                                } catch (e) {
                                  setState(() {
                                    loading = false;
                                    error = "Incorrect Email or Password";
                                  });
                                }
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Text(
                                    "Sign up",
                                    style: blackTextStyle.copyWith(
                                      decoration: TextDecoration.underline,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/signup',
                                      (route) => false,
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "|",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  child: Text(
                                    "Forgot password",
                                    style: blackTextStyle.copyWith(
                                      decoration: TextDecoration.underline,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/',
                                      (route) => false,
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
