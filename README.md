# Flutter Deep Linking Example

This project demonstrates deep linking between two Flutter apps: **Dhollu** and **Bholuu**. Using deep linking, **Bholuu** can send messages to specific screens in **Dhollu**, which displays the message and identifies the source screen.

https://github.com/user-attachments/assets/edb3d827-9c51-4d72-87a5-e055bc0eb9fa

---

## App Overview

### Dhollu
- **Screen One**: Displays the incoming message received through a deep link, along with its source.
- **Screen Two**: Displays the incoming message received through a deep link, along with its source.
  
### Bholuu
- **Screen One**: Provides a UI for sending messages using deep linking.
- **Screen Two**: Provides a UI for sending messages using deep linking.

---

## Deep Linking Flow

1. **Generate Deep Link**: **Bholuu** generates a deep link based on user input.
2. **Handle Deep Link**: **Dhollu** routes the link to the appropriate screen and displays the message.

---

## Dhollu App

### 1. Configure Deep Link in `AndroidManifest.xml`
Add the following intent filter in `Dhollu`'s Android manifest:
```xml
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="dholuu" android:host="open.my.app" />
</intent-filter>
```

### 2. Setup Routes Using GetX
```dart
 GetMaterialApp(
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

```

### 3. DeepLinkListner Widget 
```dart
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeepLinkListener extends StatefulWidget {
  const DeepLinkListener({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  State<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener> {

  @override
  void initState() {
    super.initState();
    final appLinks = AppLinks();

    appLinks.uriLinkStream.listen((uri) {
      // print('URI: ${uri.toString()}');

      final Map<String, String> param = uri.queryParameters;
      final msg = param['msg'] ?? '';

      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        final source = pathSegments[0];
        final dest = pathSegments[1];

        Get.toNamed(dest, arguments: {'from': source, 'msg': msg});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

```

## Bhollu App 

### 1.Screen One: Send Messages via Deep Linking
```dart/
List<String> sendMsgDestination = ["Screen One", "Screen Two"];
// --others imports --
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
```

## How to Run


### 1. Clone the repository
```bash
https://github.com/sohail2000/flutter_deeplink_example.git
```

### 2. Navigate to the Dhollu and Bholuu app folders
```bash
cd flutter_deeplink_example/Dhollu
flutter pub get

cd ../Bholuu
flutter pub get
```

### 3. Run the apps
# Open device/emulators and run the apps:
```bash
flutter run # in both folders separately
```

### 4. Interaction
- Use Bholuu to send a message, and observe Dhollu handling the deep link.

