import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/language_picker.dart';
import 'package:the_book_store/bloc/registration_bloc.dart';
import 'package:the_book_store/bloc/registration_event.dart';
import 'package:the_book_store/bloc/registration_state.dart';
import 'package:the_book_store/view/info_screen.dart';
import 'package:the_book_store/view/login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: SafeArea(
            child: BlocListener<RegistrationBloc, RegistrationState>(
              listener: (context, state) {
                if (state.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Registration Successful")),
                  );
                } else if (state.errorMessage != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InfoScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Register',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Create account',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Name Field
                  Text(
                    'Name',
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                  ),
                  BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      return TextField(
                        onChanged:
                            (value) => context.read<RegistrationBloc>().add(
                              NameChanged(value),
                            ),
                        decoration: InputDecoration(
                          hintText: 'Your name',
                          filled: true,
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(166, 166, 166, 1),
                          ),
                          fillColor: Color.fromRGBO(166, 166, 166, 0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),

                  // Email Field
                  Text(
                    'Email',
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                  ),
                  BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      return TextField(
                        onChanged:
                            (value) => context.read<RegistrationBloc>().add(
                              EmailChanged(value),
                            ),
                        decoration: InputDecoration(
                          hintText: 'Your email',
                          filled: true,
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(166, 166, 166, 1),
                          ),
                          fillColor: Color.fromRGBO(166, 166, 166, 0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),

                  // Password Field
                  Text(
                    'Password',
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                  ),
                  BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      return TextField(
                        obscureText: true,
                        onChanged:
                            (value) => context.read<RegistrationBloc>().add(
                              PasswordChanged(value),
                            ),
                        decoration: InputDecoration(
                          hintText: 'Your password',
                          filled: true,
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(166, 166, 166, 1),
                          ),
                          fillColor: Color.fromRGBO(166, 166, 166, 0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),

                  // Language Picker
                  Text(
                    'Language',
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(166, 166, 166, 0.1),
                    ),
                    child: LanguagePickerDropdown(
                      initialValue: Languages.english,
                      onValuePicked: (Language language) {
                        context.read<RegistrationBloc>().add(
                          LanguageChanged(language.name),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                  // Gender Selection
                  Text(
                    'Gender',
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w600),
                  ),
                  BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Radio(
                            value: "Male",
                            activeColor: Color.fromRGBO(74, 138, 196, 1),
                            fillColor: WidgetStatePropertyAll(
                              Color.fromRGBO(74, 138, 196, 1),
                            ),
                            groupValue: state.gender,
                            onChanged: (value) {
                              context.read<RegistrationBloc>().add(
                                GenderChanged(value!),
                              );
                            },
                          ),
                          Text("Male"),
                          SizedBox(width: 20),
                          Radio(
                            value: "Female",
                            activeColor: Color.fromRGBO(74, 138, 196, 1),
                            fillColor: WidgetStatePropertyAll(
                              Color.fromRGBO(74, 138, 196, 1),
                            ),
                            groupValue: state.gender,
                            onChanged: (value) {
                              context.read<RegistrationBloc>().add(
                                GenderChanged(value!),
                              );
                            },
                          ),
                          Text("Female"),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20),

                  // Register Button
                  BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed:
                            state.isSubmitting
                                ? null
                                : () => {
                                  context.read<RegistrationBloc>().add(
                                    RegisterSubmitted(),
                                  ),
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  ),
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(74, 138, 196, 1),
                          minimumSize: Size(
                            MediaQuery.sizeOf(context).width - 50,
                            56,
                          ),
                          maximumSize: Size(
                            MediaQuery.sizeOf(context).width - 50,
                            56,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child:
                            state.isSubmitting
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                  'Register',
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                      );
                    },
                  ),
                  SizedBox(height: 10),

                  // Login Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account?',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color.fromRGBO(166, 166, 166, 1),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Login',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(74, 138, 196, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Terms and Privacy Policy
                  Center(
                    child: Text(
                      'By clicking Register, you agree to our ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color.fromRGBO(166, 166, 166, 1),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Terms and Privacy Policy.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color.fromRGBO(74, 138, 196, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
