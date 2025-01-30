import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';

part 'image_pick_event.dart';
part 'image_pick_state.dart';

class ImagePickBloc extends Bloc<ImagePickEvent, ImagePickState> {
  ImagePickBloc() : super(ImagePickInitial()) {
    // image load event
    on<ImageLoadEvent>((event, emit) async {
      emit(ImageLoadingState());
      try {
        final PermissionState status =
            await PhotoManager.requestPermissionExtend();

        if (status.isAuth) {
          final List<AssetPathEntity> albums =
              await PhotoManager.getAssetPathList(type: RequestType.image);

          if (albums.isNotEmpty) {
            List<AssetEntity> media =
                await albums[0].getAssetListPaged(page: 0, size: 100);
            emit(ImageLoadedState(images: media));
          } else {
            emit(ImageErrorState("No images found"));
          }
        } else {
          emit(ImageErrorState("Permission Denied!"));
        }
      } catch (e) {
        emit(ImageErrorState("Error loading images"));
      }
    });

    // image select event
    on<ImageSelectEvent>((event, emit) async {
      final Uint8List? imageData =
          await event.image.thumbnailDataWithSize(ThumbnailSize(200, 200));
      if (imageData != null) {
        emit(ImageSelectState(imageData: imageData));
      }
    });
  }
}
