import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qualhon_app/presentation/pages/post_screen/post_screen.dart';

import '../../widget/custom_buttom.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 20,
            width: 20,
          ),
          Column(
            children: [
              
               Center(
                child: InkWell(
                  onTap: () {
                    //Navigate to post screen-
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => PostScreen()));
                  },
                  // Start button here-
                  child: CustomButton(width: 312,text: "Start",),
                ),
              ),
              Gap(30)
            ],
          ),
        ],
      ),
    );
  }
}
