import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qualhon_app/core/colors.dart';
import 'package:qualhon_app/presentation/pages/filter_screen/widget/custom_circle.dart';
import 'package:qualhon_app/presentation/pages/share_screen/share_screen.dart';

import '../first_screen/widget/custom_buttom.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text("New Post"),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_sharp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 243, 243),
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              height: 470,
              width: 355,
              decoration: BoxDecoration(
                color: kGry,
              ),
            ),
            Gap(50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomCircleAvathar(
                        isTrue: true, kColor: kMainColor, text: "Browse"),
                    CustomCircleAvathar(
                        isTrue: false, kColor: kMainDarkLite, text: "Filter 1"),
                    CustomCircleAvathar(
                        isTrue: false, kColor: kViolet, text: "Filter 2"),
                    CustomCircleAvathar(
                        isTrue: false, kColor: kCustomBLue, text: "Filter 3"),
                    CustomCircleAvathar(
                        isTrue: false, kColor: kCustomGreen, text: "Filter 4")
                  ],
                ),
                Gap(50),
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ShareScreen()));
                }, child: CustomButton(width: 117, text: "Next"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
