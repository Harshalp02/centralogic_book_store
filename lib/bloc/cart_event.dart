import 'package:equatable/equatable.dart';
import 'package:the_book_store/models/Book.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Book book;

  const AddToCart(this.book);

  @override
  List<Object> get props => [book];
}

class RemoveFromCart extends CartEvent {
  final Book book;

  const RemoveFromCart(this.book);

  @override
  List<Object> get props => [book];
}

class UpdateQuantity extends CartEvent {
  final Book book;
  final int quantity;

  const UpdateQuantity(this.book, this.quantity);

  @override
  List<Object> get props => [book, quantity];
}

class ClearCart extends CartEvent {}
