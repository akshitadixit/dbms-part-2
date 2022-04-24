import 'package:flutter/material.dart';
import 'package:travel_app/theme.dart';

class PopularCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;

  const PopularCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.location,
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
            backgroundImage: AssetImage(imageUrl,),
          ),
          SizedBox(
            width: 13,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
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
                  Text(
                    location,
                    style: greyTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/list_person.png",
                    width: 60,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "52 Reviews",
                    style: blackTextStyle.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
