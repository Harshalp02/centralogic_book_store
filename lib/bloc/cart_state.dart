
import 'package:equatable/equatable.dart';
import 'package:the_book_store/models/Book.dart';

class CartState extends Equatable {
  final List<Book> books;
  final double totalPrice;

  const CartState({this.books = const [], this.totalPrice = 0.0});

  CartState copyWith({List<Book>? books, double? totalPrice}) {
    return CartState(
      books: books ?? this.books,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object> get props => [books, totalPrice];
}

