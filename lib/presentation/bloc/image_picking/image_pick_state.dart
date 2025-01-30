part of 'image_pick_bloc.dart';

@immutable
abstract class ImagePickState {}

 class ImagePickInitial extends ImagePickState {}

 class ImageLoadingState extends ImagePickState{

 }

 class ImageLoadedState extends ImagePickState{
  final List<AssetEntity> images;

  ImageLoadedState({required this.images});
 }

 class ImageSelectState extends ImagePickState{
  final Uint8List imageData;

  ImageSelectState({required this.imageData});
 }

class ImageErrorState extends ImagePickState {
  final String message;
  ImageErrorState(this.message);
}