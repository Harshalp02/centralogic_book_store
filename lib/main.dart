import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_book_store/bloc/home_bloc.dart';
import 'package:the_book_store/bloc/home_event.dart';
import 'package:the_book_store/bloc/cart_bloc.dart';
import 'package:the_book_store/bloc/registration_bloc.dart';
import 'package:the_book_store/bloc/login_bloc.dart';

import 'package:the_book_store/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()..add(FetchDataEvent()),
        ),
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<RegistrationBloc>(create: (context) => RegistrationBloc()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Book Store',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const SplashScreen(),
      ),
    );
  }
}
