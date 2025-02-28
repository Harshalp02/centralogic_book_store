import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_book_store/bloc/cart_bloc.dart';
import 'package:the_book_store/bloc/cart_event.dart';
import 'package:the_book_store/bloc/cart_state.dart';
import 'package:the_book_store/view/order_confirmation.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Bag",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.books.isEmpty) {
            return const Center(child: Text("Your cart is empty."));
          }

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.books.length,
                    itemBuilder: (context, index) {
                      final book = state.books[index];
                      return Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(book.image, height: 48, width: 48),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.title,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 106,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(229, 243, 255, 1),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove_circle,
                                            color: Color.fromRGBO(
                                              74,
                                              138,
                                              196,
                                              1,
                                            ),
                                          ),
                                          onPressed: () {
                                            if (book.quantity > 1) {
                                              context.read<CartBloc>().add(
                                                UpdateQuantity(
                                                  book,
                                                  book.quantity - 1,
                                                ),
                                              );
                                            } else {
                                              context.read<CartBloc>().add(
                                                RemoveFromCart(book),
                                              );
                                            }
                                          },
                                        ),
                                        Text(book.quantity.toString()),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: Color.fromRGBO(
                                              74,
                                              138,
                                              196,
                                              1,
                                            ),
                                          ),
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                              UpdateQuantity(
                                                book,
                                                book.quantity + 1,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    "\$${(double.parse(book.price.replaceAll("\$", "")) * book.quantity).toStringAsFixed(2)}",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color.fromRGBO(74, 138, 196, 1),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                        RemoveFromCart(book),
                                      );
                                    },
                                    child: Text(
                                      'Remove',
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.red[500],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// 🛠 **Fixed: Constrain the ListView inside a fixed-height Container**
                      SizedBox(
                        height: 100, // Adjust this height as needed
                        child: ListView.builder(
                          itemCount: state.books.length,
                          itemBuilder: (context, index) {
                            final book = state.books[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        book.title,
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "\$${state.totalPrice.toStringAsFixed(2)}",
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Text(
                              "Subtotal",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${state.totalPrice.toStringAsFixed(2)}",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Text(
                              "Shipping",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$2",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Text(
                              "Total Payement",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${(state.totalPrice + 2).toStringAsFixed(2)}",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color.fromRGBO(74, 138, 196, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(327, 48),
                          backgroundColor: const Color.fromRGBO(
                            74,
                            138,
                            196,
                            1,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderConfirmation(),
                            ),
                          );
                        },
                        child: const Text(
                          "Pay Now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
