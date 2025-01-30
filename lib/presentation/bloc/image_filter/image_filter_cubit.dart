import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'image_filter_state.dart';

class ImageFilterCubit extends Cubit<ColorFilter> {
  ImageFilterCubit() : super(ColorFilter.mode(Colors.transparent, BlendMode.color));
  void updateFilter(ColorFilter filter) {
    emit(filter);
  }
}
