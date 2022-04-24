import 'package:flutter/material.dart';
import 'package:travel_app/theme.dart';

class Button extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;
  final String content;
  final VoidCallback onClick;
  final bool isThereIcon;
  final bool isUsingShadow;
  final double marginLeft;
  final double marginRight;
  final double borderRadius;
  final Color color;
  final TextStyle textStyle;

  const Button({
    Key? key,
    required this.width,
    required this.height,
    required this.fontSize,
    this.content = '',
    required this.onClick,
    this.isThereIcon = true,
    this.isUsingShadow = true,
    this.marginLeft = 36,
    this.marginRight = 30,
    this.borderRadius = 12,
    this.color = kPrimaryColor,
    this.textStyle = whiteTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: color,
          boxShadow: [
            (isUsingShadow)
                ? BoxShadow(
                    color: color.withOpacity(0.81),
                    spreadRadius: 0,
                    blurRadius: 24,
                    offset: Offset(5, 9), // changes position of shadow
                  )
                : BoxShadow(),
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(left: marginLeft, right: marginRight),
          child: Row(
            mainAxisAlignment: (isThereIcon)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              Text(
                content,
                style: textStyle.copyWith(
                  fontSize: fontSize,
                ),
              ),
              (isThereIcon)
                  ? Image.asset(
                      'assets/icon_arrow_right.png',
                      width: 20,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
