import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qualhon_app/core/colors.dart';
import 'package:qualhon_app/presentation/pages/first_screen/widget/custom_buttom.dart';
import 'package:qualhon_app/presentation/pages/home_screen/home_screen.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

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
      appBar: buildAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 300, // Set an explicit height
            child: PageView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 9.0),
                  child: Container(
                    color: kGry,
                    height: 200,
                  ),
                );
              },
              itemCount: 2,
            ),
          ),
          Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => HomeScreen()));
                  },
                  child: CustomButton(width: 375, text: "Share")),
              Gap(20)
            ],
          )
        ],
      ),
    );
  }
}
