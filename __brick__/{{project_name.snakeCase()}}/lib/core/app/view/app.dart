import 'package:{{project_name.snakeCase()}}/core/app/view/main_build.dart';
import 'package:{{project_name.snakeCase()}}/core/managers/theme_manager/theme_style.dart';
import 'package:{{project_name.snakeCase()}}/core/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../managers/theme_manager/theme_manager.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      final router = ref.watch(routerProvider);
      final theme = ref.watch(themeManagerProvider);
      return Listener(
        onPointerDown: (_) {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp.router(
          darkTheme: ThemeStyle.darkTheme,
          theme: ThemeStyle.lightTheme,
          themeMode: theme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerDelegate: router.delegate(),
          routeInformationParser: router.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
          builder: MainBuild.build,
        ),
      );
    });
  }
}
