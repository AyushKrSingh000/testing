import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/src/ui/web_view/webview_form.dart';

@RoutePage()
class WebViewPage extends ConsumerStatefulWidget {
  const WebViewPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebViewPageState();
}

class _WebViewPageState extends ConsumerState<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: WebViewForm(),
        ),
      ),
    );
  }
}
