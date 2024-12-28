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
