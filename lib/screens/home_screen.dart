import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/book_provider.dart";
import "book_listing_screen.dart";
import "wishlist_screen.dart";
import "profile_screen.dart";
import "../widgets/book_card.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search for books",
          ),
        ),
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          return ListView(
            children: [
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: bookProvider.suggestedBooks.map((book) =>
                      BookCard(book: book)).toList(),
                ),
              )
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WishlistScreen()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BookListingsScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

