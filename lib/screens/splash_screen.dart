import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  //const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2 saniye sonra login ekranina git
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });

    return Scaffold(
        body: Column(
      children: [
        Image.asset("assets/Karsilama_Sayfasi.png"),
      ],
    ));
  }
}
