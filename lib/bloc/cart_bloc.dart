import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import 'package:the_book_store/models/Book.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>((event, emit) {
      List<Book> updatedBooks = List.from(state.books)..add(event.book);
      double newTotalPrice = updatedBooks.fold(
        0.0,
        (sum, book) => sum + double.parse(book.price.replaceAll("\$", "")),
      );
      emit(state.copyWith(books: updatedBooks, totalPrice: newTotalPrice));
    });

    on<RemoveFromCart>((event, emit) {
      List<Book> updatedBooks = List.from(state.books)..remove(event.book);
      double newTotalPrice = updatedBooks.fold(
        0.0,
        (sum, book) => sum + double.parse(book.price.replaceAll("\$", "")),
      );
      emit(state.copyWith(books: updatedBooks, totalPrice: newTotalPrice));
    });

    on<UpdateQuantity>((event, emit) {
      List<Book> updatedBooks =
          state.books.map((book) {
            return book == event.book
                ? book.copyWith(quantity: event.quantity)
                : book;
          }).toList();
      double newTotalPrice = updatedBooks.fold(
        0.0,
        (sum, book) =>
            sum + double.parse(book.price.replaceAll("\$", "")) * book.quantity,
      );
      emit(state.copyWith(books: updatedBooks, totalPrice: newTotalPrice));
    });

    on<ClearCart>((event, emit) {
      emit(const CartState());
    });
    // on<ClearCart>((event, emit) {
    //   emit(CartState(books: [], totalPrice: 0.0));
    // });
  }
}
