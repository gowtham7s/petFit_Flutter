import 'package:flutter/material.dart';
import 'package:pet_fit/screens/imageViewer.dart';
import 'package:pet_fit/screens/videoPlayer.dart';

class PetAlbumPage extends StatefulWidget {
  const PetAlbumPage({Key? key}) : super(key: key);

  @override
  State<PetAlbumPage> createState() => _PetAlbumPageState();
}

class _PetAlbumPageState extends State<PetAlbumPage> {

  var imageList = [
    'assets/dog.png',
    'assets/dog.png',
    'assets/dog.png',
    'assets/dog.png',
    'assets/petFit.png',
    'assets/dog.png',
    'assets/petFit.png',
    'assets/dog.png',
    'assets/petFit.png',
    'assets/dog.png',
    'assets/petFit.png',
    'assets/dog.png',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey,
          title: const Text('Pet Album'),
          centerTitle: true,
          bottom:  TabBar(
            labelPadding: EdgeInsets.zero, // this one make 0
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Container(
                width: double.infinity,
                //height: 50,
                color: Colors.white, // color same as background
                child: const Tab(
                  text: "PHOTOS",
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white, // color same as background
                child: const Tab(
                  text: "VIDEOS",
                ),
              )
            ],
          ), 
        ),

        body: TabBarView(
          children:[
            ///Image Gallery
            GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5
            ), itemBuilder: (context, index){
              return RawMaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ImageViewer(imageList[index], index)
                  ));
                },
                child: Hero(
                  tag: 'image$index',
                  child: Container(
                    margin: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      image: DecorationImage(
                        image: AssetImage(imageList[index]),
                        fit: BoxFit.cover
                      ),
                    ),
                    ),
                ),
                );
            }, itemCount: imageList.length,
            ),

            ///Video Gallery
            GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5
            ), itemBuilder: (context, index){
              return RawMaterialButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const VideoPlayerPage(videoPath: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',)
                ));
              },
                child: Hero(
                  tag: 'image$index',
                  child: Container(
                    margin: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      image: DecorationImage(
                          image: AssetImage(imageList[index]),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
              );
            }, itemCount: imageList.length,
            ),
          ],
        ),
      ),
    );
  }
}
