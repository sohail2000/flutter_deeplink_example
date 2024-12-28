import 'package:bholuu/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final TextEditingController _controller = TextEditingController();
  String _currMsgDestination = sendMsgDestination[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        title: const Text("Bholuu Screen One"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter your message",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
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
                  backgroundColor: Colors.brown[200],
                ),
                onPressed: () async {
                  final message = _controller.text.trim();
                  if (message.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a message")),
                    );
                    return;
                  }
                  final url =
                      "dholuu://open.my.app/screen_one/${_currMsgDestination.replaceAll(' ', '_').toLowerCase()}?msg=$message";

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
                    _currMsgDestination = sendMsgDestination[0];
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
                onPressed: () => Get.toNamed("/screen_two"),
                child: const Text("Go to screen two"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
