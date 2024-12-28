import 'package:dholuu/deeplink_listener.dart';
import 'package:dholuu/screen_one.dart';
import 'package:dholuu/screen_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DeepLinkListener(
      child: GetMaterialApp(
        title: 'Dholuu',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => const Home(),
          ),
          GetPage(
            name: '/screen_one',
            page: () => const ScreenOne(),
          ),
          GetPage(
            name: '/screen_two',
            page: () => const ScreenTwo(),
          )
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
