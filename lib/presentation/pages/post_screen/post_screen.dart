import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:qualhon_app/core/colors.dart';
import 'package:qualhon_app/presentation/pages/filter_screen/filter_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<dynamic> images = [];
  bool isLoading = true;

  Uint8List? selectedImage;
  void selectImage(dynamic image) async {
    final Uint8List? imageData =
        await image.thumbnailDataWithSize(ThumbnailSize(200, 200));
    if (imageData != null) {
      setState(() {
        selectedImage = imageData;
      });
    }
  }

  //permission ======
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

// Request gallery permission
  Future<void> requestPermission() async {
    final PermissionState status = await PhotoManager.requestPermissionExtend();

    if (status.isAuth) {
      loadImages(); // Load images if permission is granted
    } else {
      PhotoManager.openSetting();
      //print("Permission Denied!");
    }
  }

// Load images from the gallery
  Future<void> loadImages() async {
    final List<AssetPathEntity> albums =
        await PhotoManager.getAssetPathList(type: RequestType.image);

    if (albums.isNotEmpty) {
      List<AssetEntity> media =
          await albums[0].getAssetListPaged(page: 0, size: 100);
      setState(() {
        images = media;
        isLoading = false;
      });
    }
  }

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
      actions: [
        TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => FilterScreen()));
            },
            child: Text(
              "Next",
              style: TextStyle(color: kMainColor),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 243, 243),
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 200,
                width: 350,
                child: selectedImage != null
                    ? Image.memory(selectedImage!, fit: BoxFit.cover)
                    : Center(child: Text('Select an image')),
                color: Colors.grey[400],
              ),
            ),
            Gap(10),
            //session 2-===================================================
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.file_copy_outlined,
                        size: 19,
                      ),
                      Gap(10),
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 19,
                      )
                    ],
                  )
                ],
              ),
            ),
            //session 3-=============================================================
            Gap(10),
            Row(
              children: [
                Gap(10),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 21,
                      backgroundColor: kWhite,
                      child: Image.asset(
                        "assets/recent_image.png",
                        scale: 6,
                      ),
                    ),
                    Text(
                      "Recent",
                      style: TextStyle(color: kBlack),
                    )
                  ],
                ),
                Gap(20),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 21,
                      backgroundColor: kWhite,
                      child: Image.asset(
                        "assets/gallery.png",
                        scale: 29,
                      ),
                    ),
                    Text(
                      "Photos",
                      style: TextStyle(color: kBlack),
                    )
                  ],
                ),
                Gap(20),
                Column(
                  children: [
                    CircleAvatar(
                        radius: 21,
                        backgroundColor: kWhite,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 22,
                          color: Colors.black,
                        )),
                    Text("Videos")
                  ],
                )
              ],
            ),
            Gap(20),
            //4 grid view================================================
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return FutureBuilder<Uint8List?>(
                    future: Future.value(images[index]
                        .thumbnailDataWithSize(ThumbnailSize(200, 200))),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(color: Colors.grey[300]);
                      }
                      if (snapshot.hasData) {
                        return GestureDetector(
                          onTap: () =>
                              selectImage(images[index]), // Select image
                          child:
                              Image.memory(snapshot.data!, fit: BoxFit.cover),
                        );
                      } else {
                        return Container(color: Colors.grey[300]);
                      }
                    },
                  );
                },
                itemCount: images.isNotEmpty ? images.length : 0,
              ),
            ),
            Gap(10),
            Container(
              height: 29,
              width: 327,
              decoration: BoxDecoration(
                  color: kWhite, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Container(
                  height: 20,
                  width: 80,
                  color: kWhite,
                  child: Row(
                    children: [
                      Container(
                        height: 19,
                        width: 35,
                        decoration: BoxDecoration(
                            color: kMainLite,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                          "Post",
                          style: TextStyle(color: kMainColor, fontSize: 12),
                        )),
                      ),
                      Container(
                        height: 19,
                        width: 35,
                        color: kWhite,
                        child: Center(
                            child: Text(
                          "Reel",
                          style: TextStyle(color: kBlack, fontSize: 12),
                        )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Gap(10)
          ],
        ),
      ),
    );
  }
}
