import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testing/src/logic/services/firebase_firestore.dart';

import '../../models/app_data.dart';

part 'app_list_page_model.freezed.dart';

final appListPageProvider =
    StateNotifierProvider.autoDispose<AppListPageModel, AppListPageState>(
  (ref) => AppListPageModel(
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
  ),
);

class AppListPageModel extends StateNotifier<AppListPageState> {
  final FirebaseFirestore firebaseFirestore;
  AppListPageModel({
    required this.firebaseFirestore,
  }) : super(const AppListPageState()) {
    getAppList();
  }

  getAppList() async {
    List<AppData> appData = [];
    state = state.copyWith(status: AppListStatus.loading);
    try {
      final data = await firebaseFirestore.collection('apps').get();
      if (data.docs.isNotEmpty) {
        for (var res in data.docs) {
          final value = AppData.fromJson(res.data());
          appData.add(value);
        }
      }
      if (mounted) {
        state = state.copyWith(
          appList: appData,
        );
        getApps();
      }
    } catch (e) {
      state = state.copyWith(
        status: AppListStatus.error,
      );
    }
  }

  Future<void> getApps() async {
    List<AppInfo> installedApps = [];
    installedApps.clear();

    await Future.delayed(const Duration(seconds: 1));
    final sponserApp = state.appList;
    try {
      for (var e in sponserApp ?? []) {
        await AppCheck.checkAvailability(
                Platform.isAndroid ? e.androidPackageName : e.iosPackageName)
            .then(
          (app) {
            if (app != null) {
              debugPrint(app.toString());
              installedApps.add(
                AppInfo(
                  packageName:
                      Platform.isAndroid ? app.packageName : app.packageName,
                  appName: app.appName,
                ),
              );
            }
          },
        ).onError((error, stackTrace) {
          debugPrint('App Not Found');
        });
      }

      installedApps.sort(
        (a, b) => a.appName!.toLowerCase().compareTo(b.appName!.toLowerCase()),
      );
      state = state.copyWith(
        appInfoList: installedApps,
        status: AppListStatus.loaded,
      );
    } catch (e) {
      state = state.copyWith(
        status: AppListStatus.error,
      );
      debugPrint(e.toString());
    }
  }
}

@freezed
class AppListPageState with _$AppListPageState {
  const factory AppListPageState({
    @Default(null) List<AppData>? appList,
    @Default(null) List<AppInfo>? appInfoList,
    @Default(AppListStatus.initial) status,
  }) = _AppListPageState;
}

enum AppListStatus {
  initial,
  loading,
  loaded,
  error,
}
