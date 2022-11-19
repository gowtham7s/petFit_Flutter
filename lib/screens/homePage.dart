import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {


    // const img = "assets/petFit.png";
    const img2 = "assets/dog.png";
    // var image = Image.asset(img2);

    var imageList = [
      'assets/petFit.png',
      'assets/dog.png',
      'assets/petFit.png',
      'assets/dog.png',
      'assets/petFit.png',
      'assets/dog.png',
      'assets/petFit.png',
      'assets/dog.png',
    ];

    return MaterialApp(
      title: "Scroller",
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.grey,
          ),
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {},),
          title: const Text('PetFit'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                color: Colors.grey,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    ///Horizontal scroll view
                    CarouselSlider.builder(
                      itemCount: imageList.length,
                      options: CarouselOptions(
                        height: 160,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 2),
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        } ,
                      ),
                      itemBuilder: (BuildContext context, int index, int realIndex) {
                        final img = imageList[index];
                        return buildImage(img, index);
                      },
                    ),

                    ///Space vertical 5
                    const SizedBox( height: 5),

                    ///Scroll indicator circles using listview builder
                    SizedBox(
                      height: 8,
                      child: ListView.builder(
                          itemCount: imageList.length,
                          shrinkWrap:true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return buildIndicator(activeIndex == index);
                          }),
                    ),
                  ],
                ),
              ),

            ///Space vertical 10
            const SizedBox(height: 10),

            ///List of items
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox( height: 5, );
                  },
                  itemCount: 12,
                  shrinkWrap:true,
                  itemBuilder: (BuildContext context, int index) {
                    return   Container(
                      color: Colors.grey,
                      padding: const EdgeInsets.all(5),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///Leading Image
                            SizedBox(width: 125,
                              // height: 120,
                              child: Image.asset(img2, fit: BoxFit.cover,),
                            ),

                            ///Horizontal space 10
                            const SizedBox( width: 10, ),

                            /// Pet Info (Name, age, breed, location) - Inside listview builder
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                      itemCount: 4,
                                      shrinkWrap:true,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Container(
                                            constraints: const BoxConstraints(minHeight: 22),
                                            child: const Text('Pet Name : Tiger s'));
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                    );
                  }),
            )

          ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String imgString, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 12),
    color: Colors.green,
    width: double.maxFinite,
    child:  Image.asset(imgString, fit: BoxFit.fill,),
  );

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        height: isSelected ? 12 : 10,
        width: isSelected ? 10 : 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : Colors.black38,
        ),
      ),
    );
  }
}
