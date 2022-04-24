import 'package:flutter/material.dart';
import 'package:travel_app/theme.dart';
import 'package:travel_app/widget/button.dart';

class ItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String seller;
  final VoidCallback onClick;

  const ItemCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.seller,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 8,
          right: 8,
        ),
        child: Container(
          width: 160,
          height: 265,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: kWhiteColor,
          ),
          child: Column(children: [
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    height: 120,
                    width: 120,
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(title,
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 4.0, bottom: 10.0),
                    child: Text(
                      seller,
                      style: greyTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  // InkWell(onTap: onClick, child: Text("Buy Now")),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Buy Now',
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      fixedSize: Size(90, 10),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
