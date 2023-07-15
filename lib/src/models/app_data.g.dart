// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppData _$AppDataFromJson(Map<String, dynamic> json) => AppData(
      androidPackageName: json['androidPackageName'] as String,
      appName: json['appName'] as String,
      iosPackageName: json['iosPackageName'] as String,
    );

Map<String, dynamic> _$AppDataToJson(AppData instance) => <String, dynamic>{
      'androidPackageName': instance.androidPackageName,
      'iosPackageName': instance.iosPackageName,
      'appName': instance.appName,
    };
