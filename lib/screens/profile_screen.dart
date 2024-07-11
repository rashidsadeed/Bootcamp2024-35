import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/book_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final bookProvider = Provider.of<BookProvider>(context);

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(authProvider.user?.photoURL ?? "default_image_url"),
              //backgroundImage: NetworkImage("https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login") # MADE BY AUTOCOMPLETE
            ),
            SizedBox(height: 20),
            Text(authProvider.user?.displayName ?? "username", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(authProvider.user?.email ?? "email@example.com"),
            SizedBox(height: 20),
            Text("Listed Books", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView(
                children: bookProvider.listedBooks.map((book) {
                  return ListTile(
                    leading: Image.network(book.imageUrl),
                    title: Text(book.title),
                    subtitle: Text(book.author),
                  );
                }).toList(),

                ),
            ),
          ],
        ),
      );
  }
}
