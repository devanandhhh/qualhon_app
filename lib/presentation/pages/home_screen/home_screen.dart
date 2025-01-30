import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qualhon_app/core/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      title: Text("Home"),
      centerTitle: true,
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
      appBar: buildAppbar(context),
      backgroundColor: const Color.fromARGB(255, 250, 243, 243),
      body: Column(
        children: [
          //section 1---
          Row(
            children: [
              Gap(10),
              CircleAvatar(
                radius: 21,
                backgroundColor: kMainColor,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: kWhite,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        "https://s3-alpha-sig.figma.com/img/4efc/1dd3/438046a087f2e6f98eade6514bfe9bed?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=KYgryUEvhVwG86X98ArwvJnHdk9q9cSMAQtdKhnYEWJWCxK47L9Hird0eo9sOARGqh-jCGwDWUQakKHNx7y7vYmIdxmBoXMkLVr7S3VeVL1iWnrC0vAZ2LbxKD-PUBrf52QLhVKl3gXjHzxUvGXonisA3ZFJ5UW0poCpO3Zny8-s~0-Dz~Eyh~0G8L0lvpCw1bYclcEpeG6ZBAWFPToSRUx6ZYLOHzZjOZeGb9OrFMNUTjYAhQAGvMu7lG7BJde3s7Y7Qdw~GCQ3W0fBX1fULxENfE1VoBoAlW6jNzZ4toJBmA3J8BPuBR-fh9bRXOgjOr-n7U3P7LGX2JbJodtN0Q__"),
                  ),
                ),
              ),
              Gap(5),
              Text(
                "John Karter",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Gap(10),
          //section 2---
          Container(
            height: 297,
            color: kCustomGreen,
          ),
          Container(
            height: 29,
            color: kGry,
            child: Row(
              children: [
                Gap(10),
                Text(
                  "11 hours ago",
                  style: TextStyle(color: Colors.grey),
                ),Gap(90),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.grey,
                    ),Gap(5),
                    Container(
                      height: 7,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: kMainColor),
                    ),Gap(5),
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.grey,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
