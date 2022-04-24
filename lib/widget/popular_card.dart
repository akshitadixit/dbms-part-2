import 'package:flutter/material.dart';
import 'package:travel_app/theme.dart';

class PopularCard extends StatelessWidget {
  final String img;
  final String username;

  const PopularCard({
    Key? key,
    required this.img,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kWhiteColor,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              img,
            ),
          ),
          SizedBox(
            width: 13,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/icon_location_orange.png",
                    width: 10,
                  ),
                  SizedBox(width: 5),
                  // Text(
                  //   location,
                  //   style: greyTextStyle.copyWith(
                  //     fontSize: 14,
                  //   ),
                  // ),
                ],
              ),
              // SizedBox(
              //   height: 12,
              // ),
            ],
          )
        ],
      ),
    );
  }
}
