import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  //const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2 saniye sonra login ekranina git
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });

    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/logo.eps"),
          const SizedBox(height: 20),
          const Text("Kitap dostu", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), ),
        ],
      )
    );
  }
}
