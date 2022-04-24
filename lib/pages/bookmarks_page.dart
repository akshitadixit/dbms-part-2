import 'package:flutter/material.dart';
import 'package:travel_app/widget/navigation.dart';
import 'package:travel_app/widget/popular_card.dart';
import 'package:travel_app/theme.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _bookmarkHead() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              },
              child: Image.asset(
                "assets/icon_back.png",
                width: 43,
                height: 43,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "Wishlist",
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: bold,
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 15.0, right: 15.0, bottom: 20.0),
            child: Text(
              "Add your favourite sites to Wishlist to have access them at the reach of your fingertip !",
              style: blackTextStyle.copyWith(
                color: kGreyColor,
                height: 2,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 25),
          //List
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                PopularCard(
                  imageUrl: "assets/jagannath1.jpg",
                  title: "Jagannath",
                  location: "Orissa",
                ),
                SizedBox(height: 33),
                PopularCard(
                  imageUrl: "assets/bodhgaya1.jpg",
                  title: "Bodhgaya",
                  location: "Bihar",
                ),
                SizedBox(height: 33),
                PopularCard(
                  imageUrl: "assets/ajmer_sharif1.jpg",
                  title: "Ajmer Sharif",
                  location: "Rajasthan",
                ),
              ],
            ),
          ),
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            _bookmarkHead(),
            CustomNavigation(
              home: kdisableOrange,
              market: kdisableOrange,
              bookmarks: kOrangeColor,
              user: kdisableOrange,
            ),
          ],
        ),
      ),
    );
  }
}
