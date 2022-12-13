import 'package:flutter/material.dart';
import 'package:pet_fit/screens/homePage.dart';
import 'package:pet_fit/screens/viewProducts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _validateUsername = false;
  bool _validatePassword = false;


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
              controller: _username,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none
                  ),
                errorText: _validateUsername ? "Username can't be empty" : null,
              ),
            ),
            /// Space 10
            const SizedBox(
              height: 10.0,
            ),
            /// TextField - password
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none
                  ),
                errorText: _validatePassword ? "Password can't be empty" : null,
              ),
            ),
            /// Space 20
            const SizedBox(
              height: 20.0,
            ),
            ///Button - Login
            ElevatedButton(onPressed:() {
              setState(() {
                _username.text.isEmpty?_validateUsername=true:_validateUsername=false;
                _password.text.isEmpty?_validatePassword=true:_validatePassword=false;
              });
              login();
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                ),
              ),
              child: const Text('Login'),
            ),
            ///Button - Login As Admin
            ElevatedButton(onPressed:() {
              setState(() {
                _username.text.isEmpty?_validateUsername=true:_validateUsername=false;
                _password.text.isEmpty?_validatePassword=true:_validatePassword=false;
              });
              login(isAdmin: true);
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewProductPage()));
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
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

  login({bool isAdmin = false}) async {
    if(!_validateUsername && !_validatePassword) {
      if (!isAdmin) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewProductPage()));
      }

    }
  }
}