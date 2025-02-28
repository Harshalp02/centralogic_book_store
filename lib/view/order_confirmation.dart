import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_book_store/bloc/cart_bloc.dart';
import 'package:the_book_store/bloc/cart_event.dart';
import 'package:the_book_store/view/home.dart';

class OrderConfirmation extends StatelessWidget {
  const OrderConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const Text("Order Placed Successfully!"),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(327, 48),
                backgroundColor: const Color.fromRGBO(74, 138, 196, 1),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                // 🔹 Dispatch event to clear cart
                BlocProvider.of<CartBloc>(context).add(ClearCart());

                // 🔹 Navigate back to HomeScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text(
                "Back to Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
