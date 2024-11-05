// import 'dart:io';
// import 'package:binnaz/core/managers/auth_manager/model/auth_cache_user.dart';
// import 'package:binnaz/core/managers/cache_manager/cache_manager.dart';
// import 'package:binnaz/core/managers/cache_manager/service/ICacheService.dart';
// import 'package:binnaz/core/managers/locale_manager/locale_manager.dart';
// import 'package:binnaz/core/utils/env.dart';
// import 'package:binnaz/core/utils/device_info.dart';
// import 'package:dio/dio.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class DioInterceptor extends InterceptorsWrapper {
//   final Ref ref;

//   DioInterceptor(this.ref);
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     var platform = Platform.isAndroid ? 'android' : 'ios';

//     // Retrieve device ID and name
//     var deviceId = await DeviceInfo.getDeviceId();
//     var deviceName = await DeviceInfo.getDeviceName();

//     AuthCacheUser? authUser = ref
//         .read(cacheManagerProvider(BoxType.authBox))
//         .readModelFromBox<AuthCacheUser>(BoxKey.authInfo);
//     // Set the headers for the request
//     options.headers.addAll({
//       'Accept': 'application/json',
//       'X-Device-Id': deviceId,
//       'X-Device-Name': deviceName,
//       'X-Device-Platform': platform,
//       'Accept-Language': ref.read(localeProvider).locale.languageCode,
//       'X-Api-Key': Env.apiKey,
//       if (authUser != null && authUser.accessToken != null)
//         'Authorization': 'Bearer ${authUser.accessToken}',
//     });
//     handler.next(options);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     handler.next(response);
//   }

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     handler.next(err);
//   }
// }
