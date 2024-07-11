import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/book_provider.dart";
import "book_listing_screen.dart";
import "home_screen.dart";
import "profile_screen.dart";

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    // Your existing build method code
    return Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          return ListView(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Wishlist Books", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              // Add your ListView.builder or other widgets here
            ],
          );
        },
      );
  }
}