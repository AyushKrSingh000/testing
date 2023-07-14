import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../logic/repositories/app_repository/app_repository.dart';
import '../../routing/router.dart';
import '../../utils/toast_utils.dart';
import 'auth_page_model.dart';

@RoutePage()
class AuthPage extends ConsumerWidget {
  const AuthPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appRepositoryProvider, (previous, next) {
      if (next.status != previous?.status) {
        if (next.status == AppStatus.authenticatedHasProfile) {
          context.replaceRoute(const MainRoute());
        } else if (next.status == AppStatus.authenticatedNoProfile) {
          context.replaceRoute(const MainRoute());
        }
      }
    });
    ref.listen(authPageModelProvider, (previous, next) {
      if (next.status == AuthPageStatus.error) {}
    });
    final status = ref.watch(
      authPageModelProvider.select((_) => _.status),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(
                          double.infinity,
                          60,
                        ),
                      ),
                      onPressed: () async {
                        if (status == AuthPageStatus.initial) {
                          final res = await ref
                              .read(authPageModelProvider.notifier)
                              .signin();
                          if (res == '') {
                            showSuccessMessage(
                                context, 'User Signed In Succesfully');
                          } else {
                            showErrorMessage(context, res);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: status == AuthPageStatus.authenticating ||
                                status == AuthPageStatus.authenticated
                            ? const Center(
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.amber,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Continue With Google",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.gothicA1(
                                        color: const Color(0xff0C1331),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
