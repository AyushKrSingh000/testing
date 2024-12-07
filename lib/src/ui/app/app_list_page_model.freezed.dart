// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_list_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppListPageState {
  List<AppData>? get appList => throw _privateConstructorUsedError;
  List<AppInfo>? get appInfoList => throw _privateConstructorUsedError;
  dynamic get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppListPageStateCopyWith<AppListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppListPageStateCopyWith<$Res> {
  factory $AppListPageStateCopyWith(
          AppListPageState value, $Res Function(AppListPageState) then) =
      _$AppListPageStateCopyWithImpl<$Res, AppListPageState>;
  @useResult
  $Res call(
      {List<AppData>? appList, List<AppInfo>? appInfoList, dynamic status});
}

/// @nodoc
class _$AppListPageStateCopyWithImpl<$Res, $Val extends AppListPageState>
    implements $AppListPageStateCopyWith<$Res> {
  _$AppListPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appList = freezed,
    Object? appInfoList = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      appList: freezed == appList
          ? _value.appList
          : appList // ignore: cast_nullable_to_non_nullable
              as List<AppData>?,
      appInfoList: freezed == appInfoList
          ? _value.appInfoList
          : appInfoList // ignore: cast_nullable_to_non_nullable
              as List<AppInfo>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppListPageStateCopyWith<$Res>
    implements $AppListPageStateCopyWith<$Res> {
  factory _$$_AppListPageStateCopyWith(
          _$_AppListPageState value, $Res Function(_$_AppListPageState) then) =
      __$$_AppListPageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AppData>? appList, List<AppInfo>? appInfoList, dynamic status});
}

/// @nodoc
class __$$_AppListPageStateCopyWithImpl<$Res>
    extends _$AppListPageStateCopyWithImpl<$Res, _$_AppListPageState>
    implements _$$_AppListPageStateCopyWith<$Res> {
  __$$_AppListPageStateCopyWithImpl(
      _$_AppListPageState _value, $Res Function(_$_AppListPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appList = freezed,
    Object? appInfoList = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_AppListPageState(
      appList: freezed == appList
          ? _value._appList
          : appList // ignore: cast_nullable_to_non_nullable
              as List<AppData>?,
      appInfoList: freezed == appInfoList
          ? _value._appInfoList
          : appInfoList // ignore: cast_nullable_to_non_nullable
              as List<AppInfo>?,
      status: freezed == status ? _value.status! : status,
    ));
  }
}

/// @nodoc

class _$_AppListPageState
    with DiagnosticableTreeMixin
    implements _AppListPageState {
  const _$_AppListPageState(
      {final List<AppData>? appList = null,
      final List<AppInfo>? appInfoList = null,
      this.status = AppListStatus.initial})
      : _appList = appList,
        _appInfoList = appInfoList;

  final List<AppData>? _appList;
  @override
  @JsonKey()
  List<AppData>? get appList {
    final value = _appList;
    if (value == null) return null;
    if (_appList is EqualUnmodifiableListView) return _appList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<AppInfo>? _appInfoList;
  @override
  @JsonKey()
  List<AppInfo>? get appInfoList {
    final value = _appInfoList;
    if (value == null) return null;
    if (_appInfoList is EqualUnmodifiableListView) return _appInfoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final dynamic status;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppListPageState(appList: $appList, appInfoList: $appInfoList, status: $status)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppListPageState'))
      ..add(DiagnosticsProperty('appList', appList))
      ..add(DiagnosticsProperty('appInfoList', appInfoList))
      ..add(DiagnosticsProperty('status', status));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppListPageState &&
            const DeepCollectionEquality().equals(other._appList, _appList) &&
            const DeepCollectionEquality()
                .equals(other._appInfoList, _appInfoList) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_appList),
      const DeepCollectionEquality().hash(_appInfoList),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppListPageStateCopyWith<_$_AppListPageState> get copyWith =>
      __$$_AppListPageStateCopyWithImpl<_$_AppListPageState>(this, _$identity);
}

abstract class _AppListPageState implements AppListPageState {
  const factory _AppListPageState(
      {final List<AppData>? appList,
      final List<AppInfo>? appInfoList,
      final dynamic status}) = _$_AppListPageState;

  @override
  List<AppData>? get appList;
  @override
  List<AppInfo>? get appInfoList;
  @override
  dynamic get status;
  @override
  @JsonKey(ignore: true)
  _$$_AppListPageStateCopyWith<_$_AppListPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
