import 'package:auto_route/auto_route.dart';

import '../ui/app/app_list_page.dart';
import '../ui/auth/auth_page.dart';
import '../ui/custom_map/custom_map_page.dart';
import '../ui/main/main_page.dart';
import '../ui/splash/splash_page.dart';
import '../ui/web_view/webview_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: SplashRoute.page,
    ),
    AutoRoute(
      path: '/auth',
      page: AuthRoute.page,
    ),
    AutoRoute(
      path: '/main',
      page: MainRoute.page,
    ),
    AutoRoute(
      path: '/app-list',
      page: AppListRoute.page,
    ),
    AutoRoute(
      path: '/webview-page',
      page: WebViewRoute.page,
    ),
    AutoRoute(
      path: '/custom-map',
      page: CustomMapRoute.page,
    ),
  ];
}
