import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_book_store/models/Book.dart';
import 'package:the_book_store/models/author.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    on<FetchDataEvent>((event, emit) async {
      try {
        String data = await rootBundle.loadString('lib/assets/data.json');
        Map<String, dynamic> jsonData = json.decode(data);

        List<Book> books =
            (jsonData['books'] as List)
                .map((book) => Book.fromJson(book))
                .toList();

        List<Author> authors =
            (jsonData['authors'] as List)
                .map((author) => Author.fromJson(author))
                .toList();

        emit(HomeLoadedState(books: books, authors: authors));
      } catch (e) {
        emit(HomeErrorState("Failed to load data"));
      }
    });
  }
}
