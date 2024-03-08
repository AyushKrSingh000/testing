import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/src/logic/repositories/app_repository/app_repository.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewForm extends ConsumerStatefulWidget {
  const WebViewForm({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _WebViewFormState();
}

class _WebViewFormState extends ConsumerState<WebViewForm> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: _onNavigationRequest,
      ),
    );

    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    Future.delayed(
      Duration.zero,
      () => _controller.setBackgroundColor(
        Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xff1c1c1c),
      ),
    );
    Future.delayed(Duration.zero, () async {
      final userId = await ref.watch(
        appRepositoryProvider.select((_) => _.authUser?.getIdToken()),
      );
      await exchangeIdTokenForAccessToken();

      _controller.loadRequest(
        Uri.parse(
            'https://docs.google.com/forms/d/e/1FAIpQLSfwEYxlLyjQuukYOfnrjmk8A4Lqs23eG1WfUBmOFTepeWtC6g/viewform?usp=sf_link'),
      );
    });

    _controller.enableZoom(true);
  }

  Future exchangeIdTokenForAccessToken() async {
    // Google's OAuth 2.0 token endpoint
    final tokenEndpoint =
        'https://forms.googleapis.com/v1/forms/1FAIpQLSfwEYxlLyjQuukYOfnrjmk8A4Lqs23eG1WfUBmOFTepeWtC6g/responses';

    // Request body to exchange the ID token for an access token
    // final requestBody = {
    //   'code': idToken,
    //   'client_id':
    //       '452136071352-6jgvfsgauvm0ggoetevg0rn8do3f4994.apps.googleusercontent.com',
    //   'client_secret': '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',
    //   'grant_type': 'authorization_code',
    // };
    try {
      // Send a POST request to the token endpoint
      final response = await http.get(Uri.parse(tokenEndpoint));

      if (response.statusCode == 200) {
        // Parse the response JSON and extract the access token
        print('${response.body}  jhdbbfjsdmn vmns vj jhdsf  jdkfs j');
      }

      return 'sdkjfbkjasbjkbj sk jbfdskjj jk k  ksdjfb';
    } catch (e) {
      print(e);
      return e.toString();
      // Handle error cases
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _controller,
    );
  }

  FutureOr<NavigationDecision> _onNavigationRequest(
      NavigationRequest request) async {
    return NavigationDecision.navigate;
  }
}
