class Book {
  final String id;
  final String title;
  final String author;
  final String year;
  final String price;
  final String genre;
  final String description;
  final String imageUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.year,
    required this.price,
    required this.genre,
    required this.description,
    required this.imageUrl,
  });

  factory Book.fromMap(Map<String, dynamic> data, String id) {
   return Book(
     id: id,
     title: data['title'],
     author: data['author'],
     year: data['year'],
     price: data['price'],
     genre: data['genre'],
     description: data['description'],
     imageUrl: data['imageUrl'],
      );
   }

 Map<String, dynamic> toMap() {
   return {
     'id': id,
     'title': title,
     'author': author,
     'year': year,
     'price': price,
     'genre': genre,
     'description': description,
     'imageUrl': imageUrl,
   };
 }
 }