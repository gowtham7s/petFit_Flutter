import 'package:flutter/material.dart';
import 'package:pet_fit/screens/addProduct.dart';
import 'package:pet_fit/screens/additionalWidgets.dart';
import 'package:pet_fit/screens/viewFeedback.dart';

class ProductNavigationDrawer extends StatelessWidget {
  const ProductNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: HexColor("#5A5A5A"),
      child: ListView(
        //padding: EdgeInsets.symmetric(vertical: 2),
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(  color: Colors.transparent,),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey// use instead of BorderRadius.all(Radius.circular(20))
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child:
            ListTile(
              title: const Text('All Product'),
              onTap: () => {
                Navigator.pop(context),
              },
              textColor: Colors.white,
            ),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(  color: Colors.transparent,),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey// use instead of BorderRadius.all(Radius.circular(20))
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child:
            ListTile(
              title: const Text('Add Product'),
              onTap: () => {
                Navigator.pop(context),
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductPage())),
              },
              textColor: Colors.white,
            ),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(  color: Colors.transparent,),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey// use instead of BorderRadius.all(Radius.circular(20))
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child:
            ListTile(
              title: const Text('View Feedback'),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewFeedbackPage())),
              },
              textColor: Colors.white,
            ),
          ),

          Container(
            decoration: BoxDecoration(
                border: Border.all(  color: Colors.transparent,),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey// use instead of BorderRadius.all(Radius.circular(20))
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child:
            ListTile(
              title: const Text('Logout'),
              onTap: () => {
                Navigator.of(context).pop(),
                Navigator.of(context).pop(),
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