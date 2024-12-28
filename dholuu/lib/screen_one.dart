import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final String from = arguments['from'];
    final String msg = arguments['msg'];
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: const Text("Secren One"),
      ),
      body: Center(
        child: Text("Bholuu sent message:[ $msg ] from $from"),
      ),
    );
  }
}
