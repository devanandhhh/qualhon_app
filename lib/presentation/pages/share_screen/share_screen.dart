import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qualhon_app/core/colors.dart';
import 'package:qualhon_app/presentation/widget/custom_buttom.dart';
import 'package:qualhon_app/presentation/pages/home_screen/home_screen.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen(
      {super.key, required this.image, required this.selectedFilter});

  final Future<Uint8List?> image;
  final ColorFilter selectedFilter;

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
            height: 300,
            child: PageView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 9.0),
                  child: Container(
                    color: kGry,
                    height: 200,
                    child: FutureBuilder<Uint8List?>(
                      future: image, // Use the passed image here
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          return ColorFiltered(
                            colorFilter:
                                selectedFilter, // Apply the selected filter
                            child:
                                Image.memory(snapshot.data!, fit: BoxFit.cover),
                          );
                        }
                        return Center(child: Text("No image selected"));
                      },
                    ),
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
                        MaterialPageRoute(builder: (ctx) => HomeScreen(image: image,selectedFilter: selectedFilter,)));
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
