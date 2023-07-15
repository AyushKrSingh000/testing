import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/src/constants/colors.dart';

import 'firebase_options.dart';
import 'src/logic/services/preference_service.dart';
import 'src/app.dart';

Future<void> backgroundCallback(Uri? uri) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeWidget.registerBackgroundCallback(backgroundCallback);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarColor: primaryColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // get the provisional notification permission
  await FirebaseMessaging.instance.requestPermission(
    provisional: true,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  final container = ProviderContainer(overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ]);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
