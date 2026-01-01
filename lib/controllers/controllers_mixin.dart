import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_param/app_param.dart';
import 'stock/stock.dart';
import 'toushi_shintaku/toushi_shintaku.dart';

mixin ControllersMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  //==========================================//

  AppParamState get appParamState => ref.watch(appParamProvider);

  AppParam get appParamNotifier => ref.read(appParamProvider.notifier);

  //==========================================//

  StockState get stockState => ref.watch(stockProvider);

  Stock get stockNotifier => ref.read(stockProvider.notifier);

  //==========================================//

  ToushiShintakuState get toushiShintakuState => ref.watch(toushiShintakuProvider);

  ToushiShintaku get toushiShintakuNotifier => ref.read(toushiShintakuProvider.notifier);

  //==========================================//
}
