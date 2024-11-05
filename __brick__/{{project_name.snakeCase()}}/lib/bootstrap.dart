import 'dart:async';
import 'dart:developer';
import 'package:{{project_name.snakeCase()}}/core/managers/cache_manager/cache_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/managers/locale_manager/locale_manager.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await hiveEnsureInitialized;
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final container = ProviderContainer();
    runApp(
      ProviderScope(
        child: EasyLocalization(
            useOnlyLangCode: container.read(localeProvider).useOnlyLangCode,
            path: container.read(localeProvider).path,
            supportedLocales: container.read(localeProvider).supportedLocales,
            fallbackLocale:
                container.read(localeProvider).supportedLocales.first,
            child: await builder()),
      ),
    );
  },
      (error, stackTrace) async =>
          log('$error', error: error, stackTrace: stackTrace));
}
