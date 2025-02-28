import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_book_store/models/Book.dart';
import 'package:the_book_store/models/author.dart';
import 'package:the_book_store/view/cart_screen.dart';
import 'package:the_book_store/view/category_screen.dart';
import 'package:the_book_store/view/profile_screen.dart';
import 'package:the_book_store/widgets/book_details_modal.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(27.0),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeErrorState) {
                  return Center(child: Text(state.message));
                } else if (state is HomeLoadedState) {
                  List<Book> books = state.books;
                  List<Author> authors = state.authors;

                  return Column(
                    children: [
                      /// 🔹 Top bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.search),
                          Text(
                            'Home',
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Icon(Icons.notifications_none),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 146,
                        width: 327,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Special Offer',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Discount 25%',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigate to order screen (if needed)
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(
                                      74,
                                      138,
                                      196,
                                      1,
                                    ),
                                    minimumSize: const Size(118, 36),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    'Order Now',
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              "lib/assets/images/book.png",
                              width: 100, // ✅ Fixed width
                              height: 120, // ✅ Fixed height
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// 🔹 Top of Week Section
                      sectionTitle("Top of Week"),
                      bookList(books),

                      /// 🔹 Best Vendors Section
                      sectionTitle("Best Vendors"),
                      vendorList(),

                      /// 🔹 Authors Section
                      sectionTitle("Authors"),
                      authorList(authors),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),

      /// 🔹 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromRGBO(74, 138, 196, 1),
        unselectedItemColor: const Color.fromRGBO(166, 166, 166, 1),
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.call_to_action_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  CategoryScreen()),
                );
              },
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.person_2_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
            label: 'Profile'),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Spacer(),
        Text(
          'See all',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: const Color.fromRGBO(74, 138, 196, 1),
          ),
        ),
      ],
    );
  }

  Widget bookList(List<Book> books) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          return bookCard(books[index]);
        },
      ),
    );
  }

  Widget bookCard(Book book) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // Makes it full screen
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ), // Curved top edge
          ),
          builder: (context) => BookDetailsModal(book: book),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Column(
          children: [
            Image.asset(book.image, width: 127, height: 150, fit: BoxFit.cover),
            Text(
              book.title,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              book.price,
              style: GoogleFonts.openSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget authorList(List<Author> authors) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: authors.length,
        itemBuilder: (context, index) {
          return authorCard(authors[index]);
        },
      ),
    );
  }

  Widget vendorList() {
    return
    /// 🔹 Horizontal List of Books
    SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Color.fromRGBO(250, 250, 250, 1),
              ),
              child: Image.asset("lib/assets/images/pub${index + 1}.png"),
            ),
          );
        },
      ),
    );
  }

  Widget authorCard(Author author) {
    return Padding(
      padding: EdgeInsets.only(right: 20, top: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              author.image,
              width: 102,
              height: 102,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            author.name,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            author.role,
            style: GoogleFonts.openSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
