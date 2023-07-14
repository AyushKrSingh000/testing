import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_page_model.freezed.dart';

final mainPageProvider =
    StateNotifierProvider.autoDispose<MainPageModel, MainPageState>(
  (ref) => MainPageModel(),
);

class MainPageModel extends StateNotifier<MainPageState> {
  MainPageModel() : super(const MainPageState());

  fetchUserBalance() {}
}

@freezed
class MainPageState with _$MainPageState {
  const factory MainPageState({
    @Default(0) int userBalance,
  }) = _MainPageState;
}
