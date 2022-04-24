import 'package:flutter/material.dart';
import 'package:travel_app/theme.dart';

class CustomNavigation extends StatelessWidget {
  final Color home;
  final Color market;
  final Color bookmarks;
  final Color user;

  const CustomNavigation(
      {required this.home,
      required this.market,
      required this.bookmarks,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                },
                child: Icon(
                  Icons.home,
                  color: home,
                  size: 24.0,
                )),
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/marketplace',
                    (route) => false,
                  );
                },
                child: Icon(
                  Icons.calendar_month,
                  color: market,
                  size: 24.0,
                )),
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/bookmarks',
                    (route) => false,
                  );
                },
                child: Icon(
                  Icons.bookmark,
                  color: bookmarks,
                  size: 24.0,
                )),
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/user',
                    (route) => false,
                  );
                },
                child: Icon(
                  Icons.account_box,
                  color: user,
                  size: 24.0,
                )),
          ],
        ),
      ),
      alignment: Alignment.bottomCenter,
    );
  }
}
