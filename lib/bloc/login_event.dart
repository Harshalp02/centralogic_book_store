import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Email Changed Event
class EmailChanged extends LoginEvent {
  final String email;
  EmailChanged(this.email);
  @override
  List<Object> get props => [email];
}

// Password Changed Event
class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

// Submit Event
class LoginSubmitted extends LoginEvent {}

// Toggle Password Visibility Event
class TogglePasswordVisibility extends LoginEvent {}

// Toggle Remember Me Checkbox Event
class ToggleRememberMe extends LoginEvent {
  final bool rememberMe;
  ToggleRememberMe(this.rememberMe);
  @override
  List<Object> get props => [rememberMe];
}
