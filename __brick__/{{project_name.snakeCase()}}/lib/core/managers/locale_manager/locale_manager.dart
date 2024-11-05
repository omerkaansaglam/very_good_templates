import 'package:{{project_name.snakeCase()}}/core/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _LocaleManager {
  final Ref ref;

  _LocaleManager(this.ref);

  final enLocale = const Locale('en', 'US');
  final trLocale = const Locale('tr', 'TR');
  final useOnlyLangCode = true;
  final String path = 'assets/translations';
  final fallbackLocale = const Locale('tr', 'TR');

  List<Locale> get supportedLocales => [enLocale, trLocale];

  Locale get locale {
    if (ref.read(routerProvider).navigatorKey.currentContext != null) {
      return ref.read(routerProvider).navigatorKey.currentContext!.locale;
    }
    return enLocale;
  }

  Future<void> toggleLocale() async {
    await setLocale(
      locale == enLocale ? trLocale : enLocale,
    );
  }

  Future<void> setLocale(Locale locale) async {
    await ref
        .read(routerProvider)
        .navigatorKey
        .currentContext
        ?.setLocale(locale);
    final engine = WidgetsFlutterBinding.ensureInitialized();
    await engine.performReassemble();
  }
}

final localeProvider = Provider(_LocaleManager.new);
