import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/book_provider.dart';

//an attempt to solve the firebase initialization issue using the firebase cli
import "firebase_options.dart";





// void main() async {
//    WidgetsFlutterBinding.ensureInitialized();
//
//
//    try{
//      await Firebase.initializeApp();
//      print("Firebase Initialized successfully");
//    } catch(e){
//      print("Error initializing Firebase: $e");
//    }
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => BookProvider()),
//       ],
//       child: MaterialApp(
//         title: 'Book Marketplace',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: SplashScreen(),
//       ),
//     );
//   }
// }

void main() {

  //an attempt to solve the firebase initialization issue
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return somethingWentWrong(snapshot.error.toString());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => BookProvider()),
            ],
            child: MaterialApp(
              title: 'Book Marketplace',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: SplashScreen(),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

Widget somethingWentWrong(String errorMessage) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Center(
      child: Text('Something went wrong: $errorMessage'),
    ),
  );
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Text('Loading...'),
      ),
    );
  }
}

