import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

// Existing Events
class NameChanged extends RegistrationEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class EmailChanged extends RegistrationEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegistrationEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

// New Events for Gender and Language
class GenderChanged extends RegistrationEvent {
  final String gender;
  const GenderChanged(this.gender);

  @override
  List<Object> get props => [gender];
}

class LanguageChanged extends RegistrationEvent {
  final String language;
  const LanguageChanged(this.language);

  @override
  List<Object> get props => [language];
}

class RegisterSubmitted extends RegistrationEvent {}
