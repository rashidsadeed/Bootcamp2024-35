import 'package:flutter/material.dart';
import "../models/book.dart";

class BookDetailsScreen extends StatelessWidget {
  //const BookDetailsScreen({super.key});
  final Book book;

  BookDetailsScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(book.imageUrl), //book.imageUrl refers to the database in firebase for now we use a static image
            //Image.asset("book.jpg"),
            SizedBox(height: 20),
            Text(book.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Author: ${book.author}"),
            Text("Year: ${book.year}"),
            Text("Price: ${book.price}"),
            Text("Genre: ${book.genre}"),
            Text("Description: ${book.description}"),
            Spacer(),
            ElevatedButton(onPressed: () {
              //handle contact action
            },
              child: Text("Contact Seller"),
            ), 
          ]
        ),
      ),
    );
    }
}
