import 'dart:async';

import 'package:appcheck/appcheck.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/src/ui/app/app_list_page_model.dart';

import '../../utils/toast_utils.dart';

@RoutePage()
class AppListPage extends ConsumerStatefulWidget {
  const AppListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AppListPage> createState() => _AppListPageState();
}

class _AppListPageState extends ConsumerState<AppListPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> showToastss() async {
    showSuccessMessage(context, "Checking Again!");
  }

  @override
  Widget build(BuildContext context) {
    final installedApps = ref.watch(
      appListPageProvider.select((_) => _.appInfoList),
    );
    final status = ref.watch(
      appListPageProvider.select((_) => _.status),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('App List'),
          centerTitle: true,
        ),
        body: status == AppListStatus.loaded
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: installedApps?.length,
                itemBuilder: (context, index) {
                  final app = installedApps![index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 40,
                        width: 40,
                        color: Colors.amber,
                      ),
                    ),
                    title: Text(
                      app.appName ?? app.packageName,
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      (app.isSystemApp ?? false) ? 'System App' : 'User App',
                    ),
                    trailing: GestureDetector(
                      onTap: () async {
                        AppCheck.launchApp(app.packageName).then((_) {
                          debugPrint(
                            "${app.appName ?? app.packageName} launched!",
                          );
                        }).catchError((err) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "${app.appName ?? app.packageName} not found!",
                            ),
                          ));
                          debugPrint(err.toString());
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            'Open',
                            style: GoogleFonts.outfit(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : status == AppListStatus.loading || status == AppListStatus.initial
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                  )
                : Center(child: Text('error')),
      ),
    );
  }
}
