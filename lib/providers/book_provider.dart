import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';

class BookProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Book> _suggestedBooks = [];
  List<Book> _wishlistBooks = [];
  List<Book> _listedBooks = [];

  List<Book> get suggestedBooks => _suggestedBooks;
  List<Book> get wishlistBooks => _wishlistBooks;
  List<Book> get listedBooks => _listedBooks;

  BookProvider(){
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final snapshot = await _firestore.collection('books').get();
    _suggestedBooks = snapshot.docs.map((doc) => Book.fromMap(doc.data(), doc.id)).toList();
    notifyListeners();
  }

  Future<void> addBook(String title, String author, String year, String price, String genre, String description) async {
    var book = Book(
      id: '',
      title: title,
      author: author,
      year: year,
      price: price,
      genre: genre,
      description: description,
      imageUrl: 'default_image_url',
    );
    var docRef = await _firestore.collection('books').add(book.toMap());
    book = Book(id: docRef.id, title: title, author: author, year: year, price: price, genre: genre, description: description, imageUrl: 'default_image_url');
    _listedBooks.add(book);
    notifyListeners();
  }

  void addToWishlist(Book book) {
    _wishlistBooks.add(book);
    notifyListeners();
  }

  void removeFromWishlist(Book book) {
    _wishlistBooks.remove(book);
    notifyListeners();
  }

}