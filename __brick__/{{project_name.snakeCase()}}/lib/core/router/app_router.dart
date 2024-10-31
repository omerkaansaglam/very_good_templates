import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_router.gr.dart';

final routerProvider = Provider<AppRouter>(AppRouter.new);

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  final Ref ref;

  AppRouter(this.ref);
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, initial: true),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}
