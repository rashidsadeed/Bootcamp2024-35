import 'package:flutter/material.dart';
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
              //kayit ekranina git
            },
                child: Text("Don't have an account? Sign up"))
          ]

        ),
      )
    );
  }
}

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Firestore'a kullanıcı bilgilerini kaydet
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Success"),
          content: Text("Registration Successful"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = 'An error occurred. Please try again.';
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("An error occurred. Please try again."),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                signUp(context);
              },
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}