import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../modules/about/presentation/pages/about_page.dart';
import '../../modules/auth/presentation/pages/auth_page.dart';
import '../../modules/home/presentation/pages/home_page.dart';
import '../../modules/splash/presentation/pages/splash_page.dart';
import '../dashboard/presentation/pages/dashboard_page.dart';
import '../home/domain/entities/home.dart';
import '../home_detail/presentation/pages/home_detail_page.dart';
import '../settings/presentation/pages/settings_page.dart';
import '../supportive/presentation/pages/supportive_page.dart';

part 'app_router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: DashboardRoute.page, children: [
          AutoRoute(page: HomeRoute.page),
          AutoRoute(page: AboutRoute.page),
          AutoRoute(page: SettingsRoute.page),
        ]),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: SupportiveRoute.page),
        AutoRoute(page: HomeDetailRoute.page),
      ];
}
