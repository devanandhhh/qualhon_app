import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualhon_app/presentation/bloc/image_picking/image_pick_bloc.dart';
import 'package:qualhon_app/presentation/pages/first_screen/first_screen.dart';

import 'presentation/bloc/image_filter/image_filter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> ImagePickBloc()),
        BlocProvider(create: (context)=>ImageFilterCubit())
      ],
      child: MaterialApp(
        title: 'Qualhon App',
        debugShowCheckedModeBanner: false,
        home: FirstScreen(),
      ),
    );
  }
}
