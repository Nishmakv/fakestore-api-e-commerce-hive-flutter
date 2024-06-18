import 'package:bloc/bloc.dart';
import 'package:myntra/features/auth/domain/repositories/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<UserLogin>(login);
  }

  LoginRepo loginRepo = LoginRepo();
  Future login(
    UserLogin event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final response = await loginRepo.userLogin(
        event.username,
        event.password,
      );
      if (response.success??false) {
        emit(state.copyWith(status: LoginStatus.fetched));
      } else {
        emit(state.copyWith(status: LoginStatus.exception));
      }
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.exception));
    }
  }
}
