import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_book_store/bloc/login_bloc.dart';
import 'package:the_book_store/bloc/login_event.dart';
import 'package:the_book_store/bloc/login_state.dart';
import 'package:the_book_store/view/home.dart';
import 'package:the_book_store/view/info_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  print("Current state: $state"); // Debugging log

                  if (state.isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Successful")),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  } else if (state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage!)),
                    );
                  }
                },

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button
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

                    // Welcome Text
                    Text(
                      'Welcome Back 👋',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Sign in to your account',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    Text(
                      'Email',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return TextField(
                          onChanged:
                              (value) => context.read<LoginBloc>().add(
                                EmailChanged(value),
                              ),
                          decoration: InputDecoration(
                            hintText: 'Your email',
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(184, 184, 184, 1),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    // Password Field
                    Text(
                      'Password',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return TextField(
                          obscureText: state.isPasswordVisible,
                          onChanged:
                              (value) => context.read<LoginBloc>().add(
                                PasswordChanged(value),
                              ),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(184, 184, 184, 1),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color.fromRGBO(184, 184, 184, 1),
                              ),
                              onPressed: () {
                                context.read<LoginBloc>().add(
                                  TogglePasswordVisibility(),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    // Remember Me Checkbox
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Checkbox(
                              activeColor: Color.fromRGBO(74, 138, 196, 1),
                              side: BorderSide(
                                color: Color.fromRGBO(74, 138, 196, 1),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              value: state.rememberMe,
                              onChanged: (value) {
                                context.read<LoginBloc>().add(
                                  ToggleRememberMe(value!),
                                );
                              },
                            ),
                            Text(
                              'Remember Me',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: Color.fromRGBO(74, 138, 196, 1),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    // Login Button
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed:
                              state.isSubmitting
                                  ? null
                                  : () => context.read<LoginBloc>().add(
                                    LoginSubmitted(),
                                  ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(74, 138, 196, 1),
                            minimumSize: Size(
                              MediaQuery.of(context).size.width - 50,
                              56,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child:
                              state.isSubmitting
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    // Register Option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account?',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromRGBO(184, 184, 184, 1),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to Register Screen
                          },
                          child: Text(
                            'Register',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromRGBO(74, 138, 196, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Divider
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Color.fromRGBO(184, 184, 184, 1),
                          ),
                        ),
                        const Text(
                          " Or With ",
                          style: TextStyle(
                            color: Color.fromRGBO(184, 184, 184, 1),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color.fromRGBO(184, 184, 184, 1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Google Login
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(
                          MediaQuery.of(context).size.width - 50,
                          56,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("lib/assets/images/google.png"),
                          const Text(
                            ' Sign in with Google',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Apple Login
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(
                          MediaQuery.of(context).size.width - 50,
                          56,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("lib/assets/images/apple.png"),
                          const Text(
                            ' Sign in with Apple',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
