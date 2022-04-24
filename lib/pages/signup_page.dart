import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/widget/loading.dart';
import 'package:travel_app/services/auth.dart';
import 'package:travel_app/theme.dart';
import 'package:travel_app/widget/button.dart';
import 'package:travel_app/services/db.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String email = "";
  String password = "";
  String username = "";
  String code = "";
  bool loading = false;
  get kBackgroundColor => null;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final _formKey = GlobalKey<FormState>();

    Widget header() {
      // String email = "";
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
            "Sign-Up",
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

    String username;
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
                      SizedBox(height: 65),
                      Text(
                        "Welcome!",
                        style: blackTextStyle.copyWith(
                          fontSize: 40,
                          fontWeight: semiBold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 75, right: 35, left: 35),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: 'Code (optional)',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onChanged: (value) {
                                  this.code = value;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                validator: (val) =>
                                    val!.isEmpty ? "Enter an Email" : null,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: 'E-mail',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onChanged: (val) => email = val,
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: 'Username',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onChanged: (val) => this.username = val,
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                obscureText: true, //to give password effect
                                validator: (val) => (val!.length < 6)
                                    ? "Passwords length should be 6+"
                                    : null,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onChanged: (val) => password = val,
                              ),
                              SizedBox(height: 20),
                              // TextFormField(
                              //   validator: (val) =>
                              //       (val != password && val!.length < 6)
                              //           ? "Enter the same password"
                              //           : null,
                              //   obscureText: true, //to give password effect
                              //   decoration: InputDecoration(
                              //     fillColor: Colors.grey.shade100,
                              //     filled: true,
                              //     hintText: 'Confirm your Password',
                              //     border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(10)),
                              //   ),
                              // ),
                              SizedBox(
                                height: 40,
                              ),
                              Button(
                                width: 243,
                                height: 54,
                                fontSize: 22,
                                content: 'Sign up',
                                onClick: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic user = await _auth
                                        .registerwithEmailandPassword(
                                            email, password);
                                    await FirebaseAuth.instance.currentUser
                                        ?.updateDisplayName(this.username);

                                    if (code == "") {
                                      db.addUser();
                                    } else {
                                      db.addUserbyCode(this.code);
                                    }

                                    if (user != null) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/home',
                                        (route) => false,
                                      );
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              GestureDetector(
                                child: Text(
                                  "Login",
                                  style: blackTextStyle.copyWith(
                                    decoration: TextDecoration.underline,
                                    fontSize: 20,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/login', (route) => true);
                                },
                              ),
                            ],
                          ),
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
