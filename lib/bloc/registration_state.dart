import 'package:equatable/equatable.dart';

class RegistrationState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String gender;
  final String language;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const RegistrationState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.gender = 'Male', // Default gender
    this.language = 'English', // Default language
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  RegistrationState copyWith({
    String? name,
    String? email,
    String? password,
    String? gender,
    String? language,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RegistrationState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      language: language ?? this.language,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    gender,
    language,
    isSubmitting,
    isSuccess,
    errorMessage,
  ];
}
