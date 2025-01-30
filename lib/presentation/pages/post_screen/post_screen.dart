import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:qualhon_app/core/colors.dart';
import 'package:qualhon_app/presentation/bloc/image_picking/image_pick_bloc.dart';
import 'package:qualhon_app/presentation/pages/filter_screen/filter_screen.dart';
import 'package:qualhon_app/presentation/widget/custom_snakbar.dart';

// ignore: must_be_immutable
class PostScreen extends StatelessWidget {
  PostScreen({super.key});

  List<dynamic> images = [];

  Uint8List? selectedImage;
  dynamic selectedImage1;

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
            selectedImage1 == null
                ? ScaffoldMessenger.of(context)
                    .showSnackBar(kSnakbar(text: "Please Select an Image"))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => FilterScreen(
                        image: selectedImage1,
                      ),
                    ),
                  );
          },
          child: Text(
            "Next",
            style: TextStyle(color: kMainColor),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ImagePickBloc>().add(ImageLoadEvent());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 243, 243),
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            BlocBuilder<ImagePickBloc, ImagePickState>(
              builder: (context, state) {
                if (state is ImageSelectState) {
                  return Container(
                    height: 200,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.memory(state.imageData, fit: BoxFit.cover),
                  );
                }

                return Container(
                  height: 200,
                  width: 350,
                  color: Colors.grey[400],
                  child: Center(child: Text('Select an image')),
                );
              },
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
              child: BlocBuilder<ImagePickBloc, ImagePickState>(
                builder: (context, state) {
                  if (state is ImageLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ImageLoadedState) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: state.images.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<Uint8List?>(
                          future: state.images[index]
                              .thumbnailDataWithSize(ThumbnailSize(200, 200)),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(color: Colors.grey[300]);
                            }
                            if (snapshot.hasData) {
                              return GestureDetector(
                                onTap: () {
                                  selectedImage1 = state.images[index];
                                  context.read<ImagePickBloc>().add(
                                      ImageSelectEvent(
                                          image: state.images[index]));
                                },
                                child: Image.memory(snapshot.data!,
                                    fit: BoxFit.cover),
                              );
                            }
                            return Container(color: Colors.grey[300]);
                          },
                        );
                      },
                    );
                  } else if (state is ImageErrorState) {
                    return Center(child: Text(state.message));
                  }
                  return SizedBox.shrink();
                },
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
                          ),
                        ),
                      ),
                      Container(
                        height: 19,
                        width: 35,
                        color: kWhite,
                        child: Center(
                          child: Text(
                            "Reel",
                            style: TextStyle(color: kBlack, fontSize: 12),
                          ),
                        ),
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
