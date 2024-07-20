class Book {
  final String id;
  final String title;
  final String author;
  final int year;
  final double price;
  final String genre;
  final String description;
  final String imageUrl;
  final String listedBy;
  final int yearsUsed;
  final String location;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.year,
    required this.price,
    required this.genre,
    required this.description,
    required this.imageUrl,
    required this.listedBy,
    required this.yearsUsed,
    required this.location,
  });

  factory Book.fromMap(Map<String, dynamic> data, String id) {
   return Book(
     id: id,
     title: data['title'] ?? "",
     author: data['author'] ?? "",
     year: data['year'] ?? 0,
     price: data['price'] ?? 0,
     genre: data['genre'] ?? "",
     description: data['description'] ?? "",
     imageUrl: data['imageUrl'] ?? "",
     listedBy: data['listedBy'] ?? "",
     yearsUsed: data['yearsUsed'] ?? 0,
     location: data['location'] ?? "",
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
     'listedBy': listedBy,
     'yearsUsed': yearsUsed,
     'location': location,
   };
 }
 }