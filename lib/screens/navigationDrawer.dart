import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:pet_fit/screens/addFeedback.dart';
import 'package:pet_fit/screens/addPet.dart';
import 'package:pet_fit/screens/helpWebView.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        //padding: EdgeInsets.symmetric(vertical: 2),
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/avatar.png'),
                    )
                  ),
              child: Text(formatDate(DateTime.now(), [h,':',n,' ',am]),
                textAlign: TextAlign.end,
              ),
          ),

          Container(
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 2),
            child:
            ListTile(
              title: const Text('User Profile'),
              onTap: () => {
                  showDialog(context: context,
                  barrierDismissible: false,
                  useRootNavigator: false,
                  builder: (BuildContext context){
                  return AlertDialog(
                  //insetPadding: EdgeInsets.symmetric(horizontal: 0),
                  title: const Text("Alert"),
                  content: const Text('Under development'),
                  actions: [
                  TextButton(onPressed: () {
                  Navigator.of(context).pop();
                  }, child: const Text('OK', style: TextStyle(color: Colors.teal),))
                  ],
                  );
                  }) //.then((value) => Navigator.of(context).pop());

              },
              textColor: Colors.white,
            ),
          ),

          Container(
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 2),
            child:
            ListTile(
              title: const Text('Add Pet'),
              onTap: () => {
                Navigator.pop(context),
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPetPage())),
              },
              textColor: Colors.white,
            ),
          ),

          Container(
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 2),
            child:
            ListTile(
              title: const Text('Help'),
              onTap: () => {
                Navigator.of(context).pop(),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelpWebView(title: 'Help' ,url:'https://flutter.dev',))),
              },
              textColor: Colors.white,
            ),
          ),

          Container(
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 2),
            child:
            ListTile(
              title: const Text('Feedback'),
              onTap: () => {
                Navigator.of(context).pop(),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => const AddFeedbackPage())),
              },
              textColor: Colors.white,
            ),
          ),

          Container(
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 2),
            child:
            ListTile(
              title: const Text('About'),
              onTap: () => {
                Navigator.of(context).pop(),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelpWebView(title: 'About', url: 'https://pub.dev/packages/about',))),
              },
              textColor: Colors.white,
            ),
          ),

          const SizedBox(height: 20,),

          Container(
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 2),
            child:
            ListTile(
              title: const Text('Logout'),
              onTap: () => {
                Navigator.of(context, rootNavigator: true).pop(),
              },
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ListTile(
// leading: Icon(Icons.verified_user),
// title: Text('Profile'),
// onTap: () => {Navigator.of(context).pop()},
// ),