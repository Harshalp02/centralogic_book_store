import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_book_store/bloc/cart_bloc.dart';
import 'package:the_book_store/bloc/cart_event.dart';
import 'package:the_book_store/models/Book.dart';
import 'package:the_book_store/view/cart_screen.dart';

class BookDetailsModal extends StatefulWidget {
  final Book book;

  const BookDetailsModal({super.key, required this.book});

  @override
  State<BookDetailsModal> createState() => _BookDetailsModalState();
}

class _BookDetailsModalState extends State<BookDetailsModal> {
  int quantity = 1;
  bool isFavorite = false;
  bool isClickedremove = false;
  bool isClickedAdd = false;
  @override
  Widget build(BuildContext context) {
    double price = double.parse(
      widget.book.price.replaceAll("\$", ""),
    ); // Convert to number
    double totalPrice = price * quantity;

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9, // Almost full screen
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ), // Curved top edge
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Drag Handle
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              /// 🔹 Book Image
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Center(
                  child: Image.asset(
                    widget.book.image,
                    width: 237,
                    height: 313,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// 🔹 Book Title
              Row(
                children: [
                  Text(
                    widget.book.title,
                    style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color:
                          isFavorite
                              ? Color.fromRGBO(74, 138, 196, 1)
                              : Color.fromRGBO(74, 138, 196, 1),
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 5),

              /// 🔹 Vendor Images
              Row(
                children: List.generate(1, (index) {
                  int randomNumber = Random().nextInt(4) + 1;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      height: 24,
                      width: 80,
                      child: Image.asset(
                        "lib/assets/images/pub$randomNumber.png",
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),

              /// 🔹 Book Description
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra dignissim ac ac ac. Nibh et sed ac, eget malesuada.",
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Review',
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              /// 🔹 Star Rating
              Row(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) =>
                          Icon(Icons.star, color: Colors.amber, size: 24),
                    ),
                  ),
                  Text(
                    '(5.0)',
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// 🔹 Quantity Selector & Price
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          isClickedremove = true;

                          if (quantity > 1) {
                            setState(() {
                              isClickedremove = true;
                              isClickedAdd = false;
                              quantity--;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.remove_circle,
                          color:
                              isClickedremove
                                  ? Color.fromRGBO(74, 138, 196, 1)
                                  : Color.fromRGBO(166, 166, 166, 1),
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        quantity.toString(),
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                            isClickedAdd = true;
                            isClickedremove = false;
                          });
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color:
                              isClickedAdd
                                  ? Color.fromRGBO(74, 138, 196, 1)
                                  : Color.fromRGBO(166, 166, 166, 1),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(74, 138, 196, 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CartBloc>(
                        context,
                      ).add(AddToCart(widget.book));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${widget.book.title} added to cart!"),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 48),
                      backgroundColor: const Color.fromRGBO(74, 138, 196, 1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Add to bag",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CartBloc>(
                        context,
                      ).add(AddToCart(widget.book));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(115, 48),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(
                          color: Color.fromRGBO(74, 138, 196, 1),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(color: Color.fromRGBO(74, 138, 196, 1)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
