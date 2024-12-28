import 'package:bholuu/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({super.key});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  final TextEditingController _controller = TextEditingController();
  String _currMsgDestination = sendMsgDestination[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[50],
        title: const Text("Bholuu Screen Two"),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter your message",
                border: OutlineInputBorder(),
              ),
            ),
            const Text("Message Destination"),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Radio(
                      value: sendMsgDestination[0],
                      groupValue: _currMsgDestination,
                      onChanged: (value) {
                        setState(() {
                          _currMsgDestination = sendMsgDestination[0];
                        });
                      }),
                  title: Text("${sendMsgDestination[0]} of Dholuu"),
                ),
                ListTile(
                  leading: Radio(
                      value: sendMsgDestination[1],
                      groupValue: _currMsgDestination,
                      onChanged: (value) {
                        setState(() {
                          _currMsgDestination = sendMsgDestination[1];
                        });
                      }),
                  title: Text("${sendMsgDestination[1]} of Dholuu"),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[200]),
                onPressed: () async {
                  final message = _controller.text.trim();
                  if (message.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a message")),
                    );
                    return;
                  }
                  final url =
                      "dholuu://open.my.app/screen_two/${_currMsgDestination.replaceAll(' ', '_').toLowerCase()}?msg=$message";

                  if (!await launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                    webOnlyWindowName: '_blank',
                  )) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please check your uri")),
                    );
                    return;
                  }
                  setState(() {
                    _controller.clear();
                    _currMsgDestination = sendMsgDestination[1];
                  });
                },
                child: const Text("Send Msg"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[200]),
                onPressed: () => Get.back(),
                child: const Text("Go to Back"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
