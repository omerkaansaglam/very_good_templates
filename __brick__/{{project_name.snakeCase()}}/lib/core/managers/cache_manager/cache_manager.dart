import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'service/ICacheService.dart';

Future<void> get hiveEnsureInitialized async {
  // //type id: 0
  // Hive.registerAdapter(AuthCacheUserAdapter());
  // //type id: 1
  // Hive.registerAdapter(CacheConfigAdapter());
  await Hive.initFlutter();
  // await Future.wait([
  //   Hive.openBox(BoxType.authBox.name),
  //   Hive.openBox(BoxType.configBox.name)
  // ]);
}

final cacheManagerProvider =
    Provider.family((ref, BoxType boxType) => _CacheManager(boxType.name));

class _CacheManager implements ICacheService {
  String boxName;
  late Box box;

  _CacheManager(this.boxName) {
    box = Hive.box(boxName);
  }

  @override
  T? readModelFromBox<T>(BoxKey boxKey) {
    return box.get(boxKey.name);
  }

  @override
  Future<void> writeModelToBox<T>(BoxKey boxKey, T model) async {
    await box.put(boxKey.name, model);
  }

  @override
  Future<void> clearBox() async {
    await box.clear();
  }

  @override
  Future<void> putValueToBox<T>(BoxKey boxKey, T value) async {
    await box.put(boxKey.name, value);
  }
}
