import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:qualhon_app/core/colors.dart';
import 'package:qualhon_app/presentation/bloc/image_filter/image_filter_cubit.dart';
import 'package:qualhon_app/presentation/widget/custom_circle.dart';
import 'package:qualhon_app/presentation/pages/share_screen/share_screen.dart';

import '../../widget/custom_buttom.dart';

// ignore: must_be_immutable
class FilterScreen extends StatelessWidget {
  FilterScreen({super.key, required this.image});

  final dynamic image;

  ColorFilter currentColorFilter =
      ColorFilter.mode(Colors.transparent, BlendMode.color);

  // This function changes the selected color filter
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
            FutureBuilder<Uint8List?>(
              future: image.thumbnailDataWithSize(
                ThumbnailSize(200, 200),
              ), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData && snapshot.data != null) {
                  return Container(
                    height: 470,
                    width: 355,
                    decoration: BoxDecoration(
                      color: kGry,
                    ),
                    child: image != null
                        ? BlocBuilder<ImageFilterCubit, ColorFilter>(
                            builder: (context, currentColorFilter) {
                              return ColorFiltered(
                                  colorFilter: currentColorFilter,
                                  child: Image.memory(snapshot.data!,
                                      fit: BoxFit.cover));
                            },
                          )
                        : Text("No image selected"),
                  );
                }

                return Center(child: Text("No image selected"));
              },
            ),
            Gap(50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomCircleAvathar(
                        ontap: () {
                          context.read<ImageFilterCubit>().updateFilter(
                              ColorFilter.mode(kBlack, BlendMode.color));
                        },
                        isTrue: true,
                        kColor: kMainColor,
                        text: "Browse"),
                    CustomCircleAvathar(
                        ontap: () {
                          context.read<ImageFilterCubit>().updateFilter(
                              ColorFilter.mode(kMainLite, BlendMode.color));
                        },
                        isTrue: false,
                        kColor: kMainDarkLite,
                        text: "Filter 1"),
                    CustomCircleAvathar(
                        ontap: () {
                          context.read<ImageFilterCubit>().updateFilter(
                              ColorFilter.mode(kViolet, BlendMode.color));
                        },
                        isTrue: false,
                        kColor: kViolet,
                        text: "Filter 2"),
                    CustomCircleAvathar(
                        ontap: () {
                          context.read<ImageFilterCubit>().updateFilter(
                              ColorFilter.mode(kCustomBLue, BlendMode.color));
                        },
                        isTrue: false,
                        kColor: kCustomBLue,
                        text: "Filter 3"),
                    CustomCircleAvathar(
                        ontap: () {
                          context.read<ImageFilterCubit>().updateFilter(
                              ColorFilter.mode(kCustomGreen, BlendMode.color));
                        },
                        isTrue: false,
                        kColor: kCustomGreen,
                        text: "Filter 4")
                  ],
                ),
                Gap(50),
                InkWell(
                    onTap: () {
                      final filteredImage =
                          image.thumbnailDataWithSize(ThumbnailSize(200, 200));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => ShareScreen(
                            image: filteredImage,
                            selectedFilter:
                                context.read<ImageFilterCubit>().state,
                          ),
                        ),
                      );
                    },
                    child: CustomButton(width: 117, text: "Next"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
