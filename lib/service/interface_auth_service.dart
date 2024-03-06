
import 'package:login_bloc_with_rive/init/network/dio_manager.dart';

abstract class IAuthService {
  final DioManager dioManager;

  IAuthService(this.dioManager);

  Future<String?> login({
    required String email,
    required String password,
  });
}
