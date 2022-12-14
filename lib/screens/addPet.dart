import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_fit/Model/Pet.dart';
import 'package:pet_fit/database/petServices.dart';
import 'package:pet_fit/screens/additionalWidgets.dart';
import 'dart:core';
import 'package:date_format/date_format.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';


class AddPetPage extends StatefulWidget {
  const AddPetPage({Key? key}) : super(key: key);

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {

  //final TextEditingController _date = TextEditingController();
  final Map<String, String> petMap = {
    'Pet Name : ': 'Enter Pet Name',
    'Pet DOB : ' : 'Date Of Birth',
    'Pet Location : ' : 'Enter Pet Location',
    'Pet Breed : ' : 'Enter Pet Breed'
  };

  String getValue(int index, {isKey = true}) {
    final key = petMap.keys.elementAt(index);
    final value = petMap.values.elementAt(index);
    return isKey ? key : value;
  }

  PickedFile? pickedImage;
  late File imageFile;
  bool _load = false;
  bool _isVideo = false;
  late File video;
  late VideoPlayerController _controller;
  ChewieController? _chewieController;

  final TextEditingController ownerDetailController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _breed = TextEditingController();

  bool _validateName = false;
  bool _validateDOB = false;
  bool _validateLoc = false;
  bool _validateBreed = false;
  bool _validateOwner = false;

  final _petService = PetServices();

  TextEditingController getController(int index) {
    switch (index) {
      case 0:
        return _name;
      case 1:
        return _date;
      case 2:
        return _location;
      case 3:
        return _breed;
    }
    return _date;
  }

  bool getError(int index) {
    switch (index) {
      case 0:
        return _validateName;
      case 1:
        return _validateDOB;
      case 2:
        return _validateLoc;
      case 3:
        return _validateBreed;
    }
    return _validateOwner;
  }

  String getErrorText(int index) {
    switch (index) {
      case 0:
        return "Name can't be empty";
      case 1:
        return "DOB can't be empty";
      case 2:
        return "Location can't be empty";
      case 3:
        return "Breed can't be empty";
    }
    return "Owner details can't be empty";
  }

  Future chooseImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      imageFile = File(pickedFile!.path);
      _load = true;
      _isVideo = false;
    });
    _controller.pause();
  }

  Future chooseVideo(ImageSource source) async {
    final pickedFile = await ImagePicker().pickVideo(source: source);
    setState(() {
      video = File(pickedFile!.path);
      _load = true;
      _isVideo = true;
    });
    playVideo();
  }

  playVideo() {
    //_controller = VideoPlayerController.file(video);
    _controller = VideoPlayerController.file(video)..initialize().then((_) {
      setState(() { });
      _chewieController = ChewieController(videoPlayerController: _controller);
      _controller.play();
    });

    // _chewieController = ChewieController(videoPlayerController: _controller);
    // setState(() {
    // _controller.play();
    // });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Pet'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
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
                    child: _load ?
                        _isVideo ?
                        AspectRatio(
                          aspectRatio:  _controller.value.aspectRatio,
                          child: _chewieVideoPlayer(),
                        ):
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(imageFile),
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(15.0),
                    ) :
                    Image.asset('assets/dog.png', width: 150,),
                ),
                ///Space - 10
                const SizedBox(height: 10,),
                ///Pet details
                ListView.builder(
                    itemCount: petMap.length,
                    shrinkWrap:true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          constraints: const BoxConstraints(minHeight: 25),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: Text(getValue(index),style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                                const SizedBox(width: 10,),
                                //Text('Street Dog',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                Expanded(
                                  flex: 2,
                                  child: MyTextField(
                                    readOnly: index == 1 ? true: false,
                                    controller: index == 1 ? _date : getController(index),
                                    placeholder: getValue(index, isKey: false), onTapped: () async {
                                    if (index == 1) {
                                        ///Display Date Picker
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context, //context of current state
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                            lastDate:  DateTime.now()
                                        );

                                        if(pickedDate != null ){
                                          //print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate = formatDate(pickedDate, [dd,'-',MM,'-',yyyy]); // DateFormat('yyyy-MM-dd').format(pickedDate);
                                          //print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                          _date.text = formattedDate;
                                        }
                                        // else{
                                        //   print("Date is not selected");
                                        // }
                                    }
                                  },
                                    errorText: getError(index) ? getErrorText(index): null,
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }),

                ///Owner details
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Owner Details title
                      const Text('Owner Details: ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      ///Space 10
                      const SizedBox(height: 10,),
                      ///Owner details text
                      MyTextField2(
                        controller: ownerDetailController,
                          errorText: _validateOwner ? "Owner details can't be empty":null,
                          placeholder: 'Enter Owner Details',
                          onTapped: (){ },
                      ),

                      ///Space 10
                      const SizedBox(height: 3,),

                      ///Album
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Add Pet's Photo/\nVideo :",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          IconButton(onPressed: () { 
                            
                            showModalBottomSheet<void>(
                            // context and builder are
                            // required properties in this widget
                            context: context,
                            builder: (BuildContext context) {
                            // we set up a container inside which
                            // we create center column and display text

                            // Returning SizedBox instead of a Container
                            return Container(
                              margin: const EdgeInsets.all(8),
                              height: 100,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    CustomButton(name: "Take Photo", iconName: Icons.camera, onPressed: (){
                                      Navigator.pop(context);
                                      chooseImage(ImageSource.camera);
                                    }),

                                    CustomButton(name: "Take Video", iconName: Icons.video_camera_back, onPressed: (){
                                      Navigator.pop(context);
                                      chooseVideo(ImageSource.camera);
                                    }),

                                    CustomButton(name: "Select Photo", iconName: Icons.add_photo_alternate_outlined, onPressed: (){
                                      Navigator.pop(context);
                                      chooseImage(ImageSource.gallery);
                                    }),

                                    CustomButton(name: "Select Video", iconName: Icons.video_call_rounded, onPressed: (){
                                      Navigator.pop(context);
                                      chooseVideo(ImageSource.gallery);
                                    })

                                  ],
                                ),
                              ),
                            );
                            },
                            );
                          },
                      icon: const Icon(Icons.image_outlined)),
                        ],
                      ),
                      ///Space 10
                      const SizedBox(height: 10,),

                      ///Buttons - Add
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              foregroundColor: MaterialStateProperty.all(Colors.black),
                            ),
                            onPressed: () async {

                              setState(() {
                                _name.text.isEmpty?_validateName=true:_validateName=false;
                                _date.text.isEmpty?_validateDOB=true:_validateDOB=false;
                                _location.text.isEmpty?_validateLoc=true:_validateLoc=false;
                                _breed.text.isEmpty?_validateBreed=true:_validateBreed=false;
                                ownerDetailController.text.isEmpty?_validateOwner=true:_validateOwner=false;
                              });

                              if(!_validateName && !_validateDOB && !_validateLoc && !_validateBreed && !_validateOwner) {
                                var pet = Pet();
                                pet.name = _name.text;
                                pet.dob = _date.text;
                                pet.location = _location.text;
                                pet.breed = _breed.text;
                                pet.ownerDetails = ownerDetailController.text;
                                var result = await _petService.savePet(pet);
                                if (result != null) {
                                  showAlert();
                                }
                              }

                            },
                            child: SizedBox(
                              width: mediaQuery.size.width / 3,
                              child: const Text('Add', textAlign: TextAlign.center,),
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

  Widget _chewieVideoPlayer() {
    return _chewieController != null ?
    Chewie(controller: _chewieController!,): const Text('Loading');
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController?.dispose();
  }

  showAlert() {
    showDialog(context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (BuildContext context){
          return AlertDialog(
            //insetPadding: EdgeInsets.symmetric(horizontal: 0),
            title: const Text("Alert"),
            content: const Text('New Pet added successfully'),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: const Text('OK', style: TextStyle(color: Colors.teal),))
            ],
          );
        }).then((value) => Navigator.of(context).pop());
  }



}

/*
Widget _buildButtons() {

  return Container(
    //margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //height: 100,
    width: (MediaQuery.of(context).size.width / 4 ) - 8,
    color: Colors.black,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () {
        }, icon: const Icon(Icons.camera, size: 36,color: Colors.blueGrey,)),

        Text('Take Video', textAlign: TextAlign.end, style: TextStyle(
            color: Colors.blueGrey
        ),)
      ],
    ),
  );
} */