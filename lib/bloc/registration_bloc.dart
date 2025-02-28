import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_book_store/bloc/registration_event.dart';
import 'package:the_book_store/bloc/registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(const RegistrationState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    // New Event Handlers
    on<GenderChanged>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });

    on<LanguageChanged>((event, emit) {
      emit(state.copyWith(language: event.language));
    });

    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, errorMessage: null));

      // Simulate API call delay
      await Future.delayed(Duration(seconds: 2));

      // Mock successful registration
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}
