import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {

  final String imagePath;
  final int index;
  const ImageViewer(this.imagePath, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.passthrough,
        children: [
          Hero(
            tag: 'image$index',
            child: Image(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            child:TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const SizedBox(
                  width: 120,
                  child: Text('Go Back', textAlign: TextAlign.center,),
                ),
              ),
          ),

      ]
    );
  }
}
