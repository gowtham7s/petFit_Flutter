import 'package:flutter/material.dart';
import 'package:pet_fit/screens/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_fit/screens/petDetailPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const PetDetailPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    const img = "assets/petFit.png";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Space 50
            const SizedBox(
              height: 50.0,
            ),
            /// ImageView
            Center(
              child: Container(
                width: 150.0,
                height: 150.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(img)),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  color: Colors.redAccent,
                ),
              ),
            ),
            /// Space 20
            const SizedBox(
              height: 20.0,
            ),
            /// TextField - username
            TextField(
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none
                  )
              ),
            ),
            /// Space 10
            const SizedBox(
              height: 10.0,
            ),
            /// TextField - password
            TextField(
              obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none
                  )
                ),
            ),
            /// Space 20
            const SizedBox(
              height: 20.0,
            ),
            ///Button - Login
            ElevatedButton(onPressed:() {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)
                ),
              ),
                child: const Text('Login'),
            ),
            ///Button - Login As Admin
            ElevatedButton(onPressed:() {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                ),
              ),
              child: const Text('Login As Admin'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey,
    );
  }
}

