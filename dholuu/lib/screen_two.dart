import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String from = arguments['from'];
    final String msg = arguments['msg'];
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        title: const Text("Screen Two"),
      ),
      body: Center(
        child: Text("Bholuu sent message:[ $msg ] from $from"),
      ),
    );
  }
}
