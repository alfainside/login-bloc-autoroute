import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_with_rive/init/cache/auth_cache_manager.dart';
import 'package:login_bloc_with_rive/init/cache/auth_enums.dart';
import 'package:login_bloc_with_rive/routes/app_router.dart';
import 'package:login_bloc_with_rive/service/interface_auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService authService;
  final AuthCacheManager authCacheManager;

  AuthBloc(this.authService, this.authCacheManager)
      : super(const AuthState.unknown()) {

    on<LoginRequested>(
      (event, emit) async {
        final String? response = await authService.login(
            email: event.email, password: event.password);
        if (response != null) {
          await authCacheManager.updateToken(response);
          await authCacheManager.updateLoggedIn(true);
          emit(const AuthState.authenticated());
          event.context.router.replace(const HomeRoute());
        } else {
          add(LogoutRequested());
          emit(const AuthState.error(error: AuthError.wrongEmailOrPassword));
        }
      },
    );

    on<LogoutRequested>((event, emit) async {
      try {
        await authCacheManager.signOut();
        emit(const AuthState.guest());
      } catch (_) {}
    });
  }
}
