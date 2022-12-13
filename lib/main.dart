import 'package:flutter/material.dart';
import 'package:pet_fit/screens/addFeedback.dart';
import 'package:pet_fit/screens/addPet.dart';
import 'package:pet_fit/screens/addProduct.dart';
import 'package:pet_fit/screens/homePage.dart';
import 'package:pet_fit/screens/loginPage.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:pet_fit/screens/petAlbum.dart';
import 'package:pet_fit/screens/petDetailPage.dart';
import 'package:pet_fit/screens/schedulePetActivities.dart';
import 'package:pet_fit/screens/viewFeedback.dart';
import 'package:pet_fit/screens/viewProducts.dart';

import 'screens/viewSchedule.dart';

Future main() async {
   WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

