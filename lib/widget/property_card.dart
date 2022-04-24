import 'package:flutter/material.dart';
import 'package:travel_app/theme.dart';

class PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final VoidCallback onClick;

  const PropertyCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 299,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: kWhiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                  ],
                ),
                InkWell(
                  onTap: onClick,
                  child: Image.asset(
                    "assets/img_button_detail.png",
                    width: 70,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
