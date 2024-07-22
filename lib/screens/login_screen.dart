import 'package:flutter/material.dart';
import 'package:kitapdostu/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import "home_screen.dart";

class LoginScreen extends StatelessWidget {
  //const LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
                //border: OutlineInputBorder() #THIS PART WAS ADDED BY AUTOFILL
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () async {
              bool success = await Provider.of<AuthProvider>(context, listen: false).signIn(emailController.text, passwordController.text); // THE AUTOFILL SUGGESTED USING login INSTEAD OF signIn
              if (success) {
                //login bilgileri dogruysa home ekranina git
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed")));
              }
            },
                child: Text("Login"),
            ),
            TextButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen())
              );
            },
                child: Text("Don't have an account? Sign up")
            )
          ]

        ),
      )
    );
  }
}
