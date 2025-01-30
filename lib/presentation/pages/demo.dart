import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PageDemo extends StatefulWidget {
  @override
  Page2State createState() => Page2State();
}

class Page2State extends State<PageDemo> {
  List<AssetEntity> images = [];

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    final PermissionState result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      loadImages();
    } else {
      PhotoManager.openSetting();
    }
  }

  Future<void> loadImages() async {
    final List<AssetPathEntity> albums =
        await PhotoManager.getAssetPathList(type: RequestType.image);
    if (albums.isNotEmpty) {
      List<AssetEntity> media =
          await albums[0].getAssetListPaged(page: 0, size: 100);
      setState(() {
        images = media;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gallery Images")),
      body: images.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return FutureBuilder<Widget>(
                  future: images[index]
                      .thumbnailDataWithSize(ThumbnailSize(200, 200))
                      .then((data) {
                    return Image.memory(data!, fit: BoxFit.cover);
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return snapshot.data!;
                    }
                    return Container(color: Colors.grey);
                  },
                );
              },
            ),
    );
  }
}
