import 'package:bloc/bloc.dart';
import 'package:mini_ecommerce_app/features/auth/log_in/logic/state/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  void login({required String email, required String password}) {
    emit(const LoginLoading());
    if (email == 'test@test.com' && password == '123456') {
      emit(const LoginSuccess());
      return;
    }
    emit(const LoginError('Invalid email or password'));
  }
}
