import 'package:api_bloc/screens/gallery.dart';
import 'package:api_bloc/screens/grid_view.dart';
import 'package:api_bloc/screens/list_cardview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// final String code = "BIM27841083I";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ListGallery(),);
  }
}
