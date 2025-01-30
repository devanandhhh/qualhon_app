part of 'image_pick_bloc.dart';

@immutable
abstract class ImagePickEvent {}

class ImageLoadEvent extends ImagePickEvent{

}
class ImageSelectEvent extends ImagePickEvent{
   final AssetEntity image;

  ImageSelectEvent({required this.image});
}
