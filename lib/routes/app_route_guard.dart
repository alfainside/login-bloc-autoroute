import 'package:auto_route/auto_route.dart';
import 'package:login_bloc_with_rive/init/cache/auth_cache_manager.dart';
import 'package:login_bloc_with_rive/routes/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthCacheManager authCacheManager;
  AuthGuard({required this.authCacheManager});

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    if(await authCacheManager.isLoggedIn()){
      resolver.next();
    }else {
      router.push(const OnboardingRoute());
    }
  }
}