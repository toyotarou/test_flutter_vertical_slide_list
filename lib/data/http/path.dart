enum APIPath { getAllStockData, getAllToushiShintakuData }

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.getAllStockData:
        return 'getAllStockData';
      case APIPath.getAllToushiShintakuData:
        return 'getAllToushiShintakuData';
    }
  }
}
