
import 'package:flutter/material.dart';

class CustomCircleAvathar extends StatelessWidget {
  const CustomCircleAvathar(
      {super.key,required this.ontap,
      required this.isTrue,
      required this.kColor,
      required this.text});

  final bool isTrue;
  final Color kColor;
  final String text;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: ontap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: kColor,
            child: isTrue ? Icon(Icons.music_note_outlined) : null,
          ),
          Text(text)
        ],
      ),
    );
  }
}
