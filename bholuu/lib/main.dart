import 'package:bholuu/screen_one.dart';
import 'package:bholuu/screen_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bholuu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black87),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const ScreenOne(),
        ),
        GetPage(
          name: '/screen_two',
          page: () => const ScreenTwo(),
        )
      ],
    );
  }
}
