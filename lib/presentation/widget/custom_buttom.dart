
import 'package:flutter/material.dart';

import '../../core/colors.dart';

class CustomButton extends StatelessWidget {
 const  CustomButton({
    super.key,required this.width,required this.text
  });

  // final double height;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.circular(60)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: kWhite,
          ),
        ),
      ),
    );
  }
}
