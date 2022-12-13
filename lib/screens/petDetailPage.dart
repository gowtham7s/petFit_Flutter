import 'package:flutter/material.dart';
import 'package:pet_fit/Model/Pet.dart';
import 'package:pet_fit/database/petServices.dart';
import 'package:pet_fit/screens/petAlbum.dart';
import 'package:pet_fit/screens/schedulePetActivities.dart';
import 'package:pet_fit/screens/viewSchedule.dart';
import 'package:url_launcher/url_launcher.dart';

class PetDetailPage extends StatefulWidget {
  final Pet petDetail;
  //const PetDetailPage({Key? key, required this.petDetail}) : super(key: key);

  const PetDetailPage({super.key, required this.petDetail});

  @override
  State<PetDetailPage> createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {

  List<String> lists = ['Pet Name : ', 'Pet Age : ', 'Pet Location : ', 'Pet Breed : '];
  final _petService = PetServices();

  String getItem(int index) {
    switch (index) {
      case 0:
        return widget.petDetail.name ?? "";
      case 1:
        return widget.petDetail.dob ?? "";
      case 2:
        return widget.petDetail.location ?? "";
      case 3:
        return widget.petDetail.breed ?? "";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Pet Details'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(8),
            height: mediaQuery.size.height - 100,
            width: mediaQuery.size.width,
            color: Colors.grey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Column(
                children: [
                  ///Space at top - 10
                  const SizedBox(height: 10,),
                  ///Image of the Pet
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('assets/dog.png', width: 150,)
                  ),
                  ///Space - 10
                  const SizedBox(height: 10,),
                  ///Pet details
                  ListView.builder(
                      itemCount: 4,
                      shrinkWrap:true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            constraints: const BoxConstraints(minHeight: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 Expanded( flex: 1,
                                     child: Text(lists[index],style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                                 //const SizedBox(width: 10,),
                                Expanded(flex: 2,
                                    child: Text(getItem(index),style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                              ],
                            ));
                      }),

                  ///Owner details
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Owner Details title
                          const Text('Owner Details: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          ///Space 10
                          const SizedBox(height: 10,),
                          ///Owner details text
                          _buildTextField(widget.petDetail.ownerDetails),

                          ///Album
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Album',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              IconButton(onPressed: () {
                                //print('pressed');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const PetAlbumPage()));
                              }, icon: const Icon(Icons.image_outlined)),
                            ],
                          ),
                          ///Space 10
                          const SizedBox(height: 10,),
                          ///Schedule
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 0,
                                child: Text('Schedule',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              ),

                              Column(
                                children: [
                                  IconButton(onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SchedulePetPage(petDetail: widget.petDetail,)));
                                  }, icon: const Icon(Icons.calendar_month_outlined)),
                                  const Text('Create'),
                                ],
                              ),

                              Column(
                                children: [
                                  IconButton(onPressed: () {
                                    //print('view pressed');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewSchedulePage(id: widget.petDetail.id!,)));
                                  }, icon: const Icon(Icons.view_timeline_outlined)),
                                  const Text('View'),
                                ],
                              ),
                            ],
                          ),

                          ///Space 10
                          const SizedBox(height: 10,),

                          ///Buttons - call and Delete
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  foregroundColor: MaterialStateProperty.all(Colors.black),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _launchUrl();
                                  });
                                },
                                child: SizedBox(
                                  width: mediaQuery.size.width / 3,
                                  child: const Text('Call', textAlign: TextAlign.center,),
                                ),
                              ),

                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  foregroundColor: MaterialStateProperty.all(Colors.black),
                                ),
                                onPressed: () async {
                                  showAlert();
                                  // var result = await _petService.removePet(widget.petDetail.id!);
                                  // if (result != null) {
                                  //   Navigator.pop(context);
                                  // }
                                },
                                child: SizedBox(
                                  width: mediaQuery.size.width / 3,
                                  child: const Text('Delete', textAlign: TextAlign.center,),
                                ),
                              ),
                            ],
                          ),
                        ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget _buildTextField(String? text) {

    return TextField(
      enabled: false,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 4,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: text,
        border: InputBorder.none,
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse('tel:+1-555-010-999'))) {
      throw 'Could not launch tel:+1-555-010-999';
    }
  }

  showAlert() {
    showDialog(context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (BuildContext context){
          return AlertDialog(
            //insetPadding: EdgeInsets.symmetric(horizontal: 0),
            title: const Text("Delete"),
            content: const Text('Are you sure you want to delete'),
            actions: [
              TextButton(onPressed: () async {
                var result = await _petService.removePet(widget.petDetail.id!);
                if (result != null) {
                   Navigator.pop(context, 0);
                }
              }, child: const Text('Yes', style: TextStyle(color: Colors.teal),)),

              TextButton(onPressed: () {
                Navigator.pop(context, 1);
              }, child: const Text('No', style: TextStyle(color: Colors.teal),))
            ],
          );
        }).then((value) {
          if (value == 0) {
            Navigator.of(context).pop(); }
        });

  }
}
