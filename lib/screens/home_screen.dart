import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/book_provider.dart";
import "book_listing_screen.dart";
import "wishlist_screen.dart";
import "profile_screen.dart";
import "../widgets/book_card.dart";

List<String> genres = ['Fiction', 'Non-fiction', 'Sci-Fi', 'Fantasy', 'Biography', 'History', 'Mystery', 'Romance', 'Horror', 'Thriller'];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Kitap Dostu")
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for a book",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                ),
                ),
              ),
              //to create a slide show of different genres
              GenresCards(),
              SizedBox(height: 10,),

              //this part was used to check the refresh function of the bookprovider
              // Container(
              //   padding: EdgeInsets.all(8),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       bookProvider.refreshBooks();
              //       print("number of books: ${bookProvider.listedBooks.length}");
              //     },
              //     child: Text("List a book"),
              // ),
              // ),
              //to create a slide show of different books
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Recent Books", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              BooksSlider(),

              
              

              
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

class GenresCards extends StatelessWidget {
  const GenresCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: genres.map((genre) =>
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => GenreScreen(genre: genre)),
    
                    //temporarily using the same screen for all genres to avoid errors
                    MaterialPageRoute(builder: (context) => WishlistScreen()),
    
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        genre,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              )).toList(),
        ),
        );
  }
}

class BooksSlider extends StatelessWidget {
  const BooksSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, child) {
        return Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: bookProvider.listedBooks.map((book) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Author: ${book.author}',
                      style: TextStyle(fontSize: 11),
                    ),
                    Text(
                      'Price: \$${book.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
        );
      },
    );
  }
}
