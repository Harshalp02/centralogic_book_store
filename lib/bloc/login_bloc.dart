import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    });

    on<ToggleRememberMe>((event, emit) {
      emit(state.copyWith(rememberMe: event.rememberMe));
    });

    on<LoginSubmitted>((event, emit) async {
      if (state.email.isEmpty || state.password.isEmpty) {
        emit(
          state.copyWith(errorMessage: "Email and Password cannot be empty"),
        );
        return;
      }

      emit(
        state.copyWith(isSubmitting: true, errorMessage: null),
      ); // Reset errors

      await Future.delayed(const Duration(seconds: 2)); // Simulate API delay

      // Simulating a successful login
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}
