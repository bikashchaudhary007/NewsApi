import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:newsapi_pratice/loginpage.dart';


import 'dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCIdOfcqD6NJdW0-2fr4UcDciMy83cw-ls',
      appId: '1:633066046209:android:b087774fb53ca0bc7b1100',
      messagingSenderId: '633066046209',
      projectId: 'newsapp-387c3',
      authDomain: 'newsapp-387c3.firebaseapp.com',
      databaseURL: 'https://console.firebase.google.com/u/1/project/newsapp-387c3/database/newsapp-387c3-default-rtdb/data/~2F',
      storageBucket: 'newsapp-387c3.appspot.com',
      measurementId: 'G-F79DJ0VFGS',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Api',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

