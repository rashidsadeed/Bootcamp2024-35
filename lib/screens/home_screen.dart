import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/book_provider.dart";
import "book_listing_screen.dart";
import "wishlist_screen.dart";
import "profile_screen.dart";
import "../widgets/book_card.dart";

List<String> genres = ['Fiction', 'Non-fiction', 'Sci-Fi', 'Fantasy', 'Biography', 'History', 'Mystery', 'Romance', 'Horror', 'Thriller'];


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreenContent(),
    const WishlistScreen(),
    const ProfileScreen(),
  ];

  static final List<String> _titles = <String>[
    'Home',
    'Wishlist',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _selectAppBar(_selectedIndex),
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
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
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
    );
  }

  AppBar _selectAppBar(int index) {
  switch (index) {
    case 0: // Home
      return AppBar(
        title: Text(_titles[index]),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      );
    case 1: // Wishlist
      return AppBar(
        title: Text(_titles[index]),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        )
      );
    case 2: // Profile
      return AppBar(
        title: Text(_titles[index]),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        )
      );
    default:
      return AppBar(
        title: Text('Page'),
      );
  }
}
}




class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Expanded( // Wrap ListView in Expanded
          child: Consumer<BookProvider>(
            builder: (context, bookProvider, child) {
              return ListView(
                children: [
                  GenresCards(),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Recent Books", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  BooksSlider(),
                ],
              );
            },
          ),
        ),
      ],
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
