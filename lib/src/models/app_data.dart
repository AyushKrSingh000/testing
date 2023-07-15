import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_data.g.dart';

@JsonSerializable()
class AppData {
  final String androidPackageName;
  final String iosPackageName;
  final String appName;

  const AppData({
    required this.androidPackageName,
    required this.appName,
    required this.iosPackageName,
  });

  factory AppData.fromJson(Map<String, dynamic> json) =>
      _$AppDataFromJson(json);
}
