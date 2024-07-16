import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/Image_repository_impl.dart';
import 'package:image_search_app/di/di_setup.dart';
import 'package:image_search_app/ui/image/image_screen.dart';
import 'package:image_search_app/ui/image/image_view_model.dart';
import 'package:provider/provider.dart';



void main() {
  diSetUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       home : ChangeNotifierProvider(
         create: (_) => getIt<ImageViewModel>(),
         child: const ImageScreen(),
       )
    );
  }
}


