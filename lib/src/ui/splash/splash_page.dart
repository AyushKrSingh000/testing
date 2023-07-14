import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../logic/repositories/app_repository/app_repository.dart';
import '../../constants/colors.dart';
import '../../routing/router.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  bool isChanged = true;
  late final Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      setState(() {
        isChanged = !isChanged;
      });
    });
    timer;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(appRepositoryProvider, (previous, next) async {
      if (next.status != previous?.status) {
        final router = context.router;
        switch (next.status) {
          case AppStatus.initial:
            // do nothing
            router.replace(const AuthRoute());
            break;
          case AppStatus.unauthenticated:
            // navigate to auth after a delay
            await Future.delayed(const Duration(milliseconds: 2400));
            router.replace(const AuthRoute());
            break;
          case AppStatus.authenticatedHasProfile:
            // navigate to create profile after a delay
            await Future.delayed(const Duration(milliseconds: 2400));
            router.replace(const MainRoute());
            break;
          case AppStatus.authenticatedNoProfile:
            // navigate to main after a delay
            await Future.delayed(const Duration(milliseconds: 2400));
            router.replace(const MainRoute());
            break;
        }
      }
    });
    return Scaffold(
      backgroundColor: primaryColor,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: isChanged ? primaryColor : Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Hi YAish')],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }
}
