import 'package:flutter/material.dart';

class PromoText extends StatelessWidget {
  final String title;
  final String subtitle;
  final double? tSize;
  final double? sSize;
  final Color? color;
  final MainAxisAlignment mAlignment;
  final CrossAxisAlignment cAlignment;
  final TextAlign tAlign;
  const PromoText({
    Key? key,
    required this.title,
    required this.subtitle,
    this.tSize = 20,
    this.sSize = 14,
    this.color = Colors.black,
    this.mAlignment = MainAxisAlignment.start,
    this.cAlignment = CrossAxisAlignment.start,
    this.tAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: cAlignment,
      mainAxisAlignment: mAlignment,
      textDirection: TextDirection.ltr,
      children: [
        Text(
          title,
          style: TextStyle(
            overflow: TextOverflow.fade,
            fontSize: tSize,
            color: color,
            fontWeight: FontWeight.bold,
            fontFamily: 'Product',
          ),
          textAlign: tAlign,
        ),
        Text(
          subtitle,
          textAlign: tAlign,
          style: TextStyle(
            overflow: TextOverflow.fade,
            fontSize: sSize,
            color: color!.withOpacity(0.5),
            fontWeight: FontWeight.normal,
            fontFamily: 'Product',
          ),
        ),
      ],
    );
  }
}
