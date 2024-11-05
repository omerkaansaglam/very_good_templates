///Type of the boxes we have in the app
enum BoxType { authBox, configBox }

///All the keys we have in  the app to store in cache
enum BoxKey { authInfo, configInfo }

abstract class ICacheService {
  T? readModelFromBox<T>(BoxKey boxKey);
  Future<void> writeModelToBox<T>(BoxKey boxKey, T model);
  Future<void> clearBox();
  Future<void> putValueToBox<T>(BoxKey boxKey, T value);
}
