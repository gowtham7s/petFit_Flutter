import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  const MyTextField({super.key, required this.placeholder, required this.onTapped, this.controller, this.errorText});
  final String placeholder;
  final VoidCallback onTapped;
  final TextEditingController? controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: true,
      keyboardType: TextInputType.multiline,
      onTap: onTapped,
      //maxLines: null,
      //minLines: 3,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: placeholder,
        //labelText: txt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        errorText: errorText,
      ),
    );
  }
}

class MyTextField2 extends StatelessWidget {

  const MyTextField2({super.key, required this.placeholder, required this.onTapped, this.controller, this.errorText});
  final String placeholder;
  final VoidCallback onTapped;
  final TextEditingController? controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: true,
      keyboardType: TextInputType.multiline,
      onTap: onTapped,
      maxLines: null,
      minLines: 3,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: placeholder,
        //labelText: txt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        errorText: errorText,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {

  final String name;
  final IconData iconName;
  final VoidCallback onPressed;
  const CustomButton({Key? key, required this.name, required this.iconName, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        //margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        //height: 100,
        width: (MediaQuery.of(context).size.width / 4 ) - 8,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: onPressed, icon: Icon(iconName, size: 36,color: Colors.blueGrey,)),

            Text(name, textAlign: TextAlign.end, style: const TextStyle(
                color: Colors.blueGrey
            ),)
          ],
        ),
      );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}