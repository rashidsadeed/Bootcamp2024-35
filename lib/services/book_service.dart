import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book.dart';

class BookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Book>> getBooks() async {
    var snapshot = await _firestore.collection('books').get();
    return snapshot.docs.map((doc) => Book.fromMap(doc.data(), doc.id)).toList();
  }

  Future<void> addBook(Book book) async {
    await _firestore.collection('books').add(book.toMap());
  }
}