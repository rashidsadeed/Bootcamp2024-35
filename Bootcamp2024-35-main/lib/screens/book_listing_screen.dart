import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/book_provider.dart";

class BookListingsScreen extends StatelessWidget {
  //const BookListingsScreen({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController yearsUsedController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  //no longer needed since the UID is used instead
  //final TextEditingController listedByController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List a book"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Title",
              ),
              controller: titleController
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: "Author",
                ),
                controller: authorController
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: "Year",
                ),
                controller: yearController
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: "Price",
                ),
                controller: priceController
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: "Genre",
                ),
                controller: genreController
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
                controller: descriptionController
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: "Image URL",
                ),
                controller: imageUrlController
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: "yearsUsed",
                ),
                controller: yearsUsedController
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: "Location",
                ),
                controller: locationController
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Provider.of<BookProvider>(context, listen: false).addBook(
                    titleController.text,
                    authorController.text,
                    int.parse(yearController.text),
                    double.parse(priceController.text),
                    genreController.text,
                    descriptionController.text,
                    imageUrlController.text,
                    int.parse(yearsUsedController.text),
                    locationController.text,
                  );
                  Navigator.pop(context);
                },
                child: Text("Submit")
            ),
          ],
        ),
      ),
    );
  }
}
