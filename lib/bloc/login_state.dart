import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isPasswordVisible; // ✅ Add this field
  final bool rememberMe; // ✅ Add this field
  final String? errorMessage;
  final String? emailError;
  final String? passwordError;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isPasswordVisible = false, // ✅ Default to false
    this.rememberMe = false, // ✅ Default to false
    this.errorMessage,
    this.emailError,
    this.passwordError,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isPasswordVisible, // ✅ Add this parameter
    bool? rememberMe, // ✅ Add this parameter
    String? errorMessage,
    String? emailError,
    String? passwordError,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isPasswordVisible:
          isPasswordVisible ?? this.isPasswordVisible, // ✅ Fix here
      rememberMe: rememberMe ?? this.rememberMe, // ✅ Fix here
      errorMessage: errorMessage,
      emailError: emailError,
      passwordError: passwordError,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    isSubmitting,
    isSuccess,
    isPasswordVisible, // ✅ Include in props
    rememberMe, // ✅ Include in props
    errorMessage,
    emailError,
    passwordError,
  ];
}
