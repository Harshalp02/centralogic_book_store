
import 'package:equatable/equatable.dart';
import 'package:the_book_store/models/Book.dart';
import 'package:the_book_store/models/author.dart';


abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Book> books;
  final List<Author> authors;

  HomeLoadedState({required this.books, required this.authors});

  @override
  List<Object> get props => [books, authors];
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);

  @override
  List<Object> get props => [message];
}

