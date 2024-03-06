import 'package:auto_route/auto_route.dart';
import 'package:login_bloc_with_rive/init/cache/auth_cache_manager.dart';
import 'package:login_bloc_with_rive/routes/app_route_guard.dart';
import 'package:login_bloc_with_rive/screen/home/home_page.dart';
import 'package:login_bloc_with_rive/screen/onboarding/onboding_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen|View,Route')
class AppRouter extends _$AppRouter {
  @override      
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: HomeRoute.page, initial: true, guards: [AuthGuard(authCacheManager: AuthCacheManager())]),
  ];
}    
