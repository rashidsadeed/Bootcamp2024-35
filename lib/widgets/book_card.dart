import 'package:flutter/material.dart';
import '../models/book.dart';
import '../screens/book_details_screen.dart';

class BookCard extends StatelessWidget {
  //const BookCard({super.key});
  final Book book;

  BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetailsScreen(book: book)));
      },
      child: Card(
        child: Column(
          children: [
            Image.network(book.imageUrl),
            Text(book.title),
            Text(book.author),
          ]
        ),
      ),
    );
  }
}
