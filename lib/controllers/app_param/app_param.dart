import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/stock_model.dart';

import '../../models/toushi_shintaku_model.dart';

import '../../utility/utility.dart';

part 'app_param.freezed.dart';

part 'app_param.g.dart';

@freezed
class AppParamState with _$AppParamState {
  const factory AppParamState({
    @Default(<String, List<StockModel>>{}) Map<String, List<StockModel>> keepStockMap,
    @Default(<String, List<ToushiShintakuModel>>{}) Map<String, List<ToushiShintakuModel>> keepToushiShintakuMap,

    @Default(<String, List<StockModel>>{}) Map<String, List<StockModel>> keepStockTickerMap,
    @Default(<int, List<ToushiShintakuModel>>{}) Map<int, List<ToushiShintakuModel>> keepToushiShintakuRelationalMap,
  }) = _AppParamState;
}

@riverpod
class AppParam extends _$AppParam {
  final Utility utility = Utility();

  ///
  @override
  AppParamState build() {
    return const AppParamState();
  }

  ///
  void setKeepStockMap({required Map<String, List<StockModel>> map}) => state = state.copyWith(keepStockMap: map);

  ///
  void setKeepToushiShintakuMap({required Map<String, List<ToushiShintakuModel>> map}) =>
      state = state.copyWith(keepToushiShintakuMap: map);

  ///
  void setKeepStockTickerMap({required Map<String, List<StockModel>> map}) =>
      state = state.copyWith(keepStockTickerMap: map);

  ///
  void setKeepToushiShintakuRelationalMap({required Map<int, List<ToushiShintakuModel>> map}) =>
      state = state.copyWith(keepToushiShintakuRelationalMap: map);
}
