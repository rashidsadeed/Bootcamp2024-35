import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/book_provider.dart";

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          return ListView(
              children:
                bookProvider.wishlistBooks.map((book) {
                  return ListTile(
                    leading: Image.network(book.imageUrl),
                    title: Text(book.title),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        bookProvider.removeFromWishlist(book);
                      },
                    ),
                  );
                }).toList(),
          );
        },
      ),
    );
  }
}
