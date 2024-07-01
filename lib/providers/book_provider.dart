import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    try {
      final snapshot = await _firestore.collection('books').get();
      _listedBooks =
          snapshot.docs.map((doc) => Book.fromMap(doc.data(), doc.id)).toList();
      notifyListeners();
    } catch (e){
      print("Error loading books: $e");
    }
  }

  //to refresh the listedbooks list and get the book in the database
  Future<void> refreshBooks() async {
    await _loadBooks();
  }

  Future<void> addBook(String title, String author, int year, double price, String genre, String description, String image_url, int yearsUsed, String location) async {
    //gets the users UID to list the book under their name
    var seller_id = FirebaseAuth.instance.currentUser!.uid;

    var book = Book(
      id: '',
      title: title,
      author: author,
      year: year,
      price: price,
      genre: genre,
      description: description,
      imageUrl: image_url,
      listedBy: seller_id,
      yearsUsed: yearsUsed,
      location: location,
    );
    var docRef = await _firestore.collection('books').add(book.toMap());
    book = Book(id: docRef.id, title: title, author: author, year: year, price: price, genre: genre, description: description, imageUrl: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-png%2Fbook&psig=AOvVaw18EXb8cNxgqyMa5Qx3A7n_&ust=1719873134378000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJDr-uywhIcDFQAAAAAdAAAAABAE', listedBy: seller_id, yearsUsed: yearsUsed, location: location);
    _listedBooks.add(book);
    notifyListeners();

    //to add each entered book to the users listedBooks array
    await _firestore.collection("users").doc(seller_id).update({
      "listedBooks": FieldValue.arrayUnion([docRef.id])
    });
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