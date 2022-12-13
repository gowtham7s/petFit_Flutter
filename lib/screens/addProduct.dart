import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_fit/Model/Pet.dart';
import 'package:pet_fit/database/petServices.dart';
import 'package:pet_fit/screens/additionalWidgets.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  final Map<String, String> productMap = {
    'Product Name :': 'Enter Name',
    'Product Cost :' : 'Enter Cost',
    'Product Image :' : 'Enter Url',
    'Available Stock :' : 'Enter Stock'
  };

  String getValue(int index, {isKey = true}) {
    final key = productMap.keys.elementAt(index);
    final value = productMap.values.elementAt(index);
    return isKey ? key : value;
  }

  PickedFile? pickedImage;
  late File imageFile;
  bool _load = false;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _cost = TextEditingController();
  final TextEditingController _url = TextEditingController();
  final TextEditingController _stock = TextEditingController();

  bool _validateName = false;
  bool _validateCost = false;
  bool _validateUrl = false;
  bool _validateStock = false;

  final _petService = PetServices();

  TextEditingController getController(int index) {
    switch (index) {
      case 0:
        return _name;
      case 1:
        return _cost;
      case 2:
        return _url;
    }
    return _stock;
  }

  bool getError(int index) {
    switch (index) {
      case 0:
        return _validateName;
      case 1:
        return _validateCost;
      case 2:
        return _validateUrl;
    }
    return _validateStock;
  }

  String getErrorText(int index) {
    switch (index) {
      case 0:
        return "Name can't be empty";
      case 1:
        return "Cost can't be empty";
      case 2:
        return "URL can't be empty";
      case 3:
        return "Available Stock can't be empty";
    }
    return  "Name can't be empty";
  }

  Future chooseImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      imageFile = File(pickedFile!.path);
      _load = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Add Products'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          //height: mediaQuery.size.height - 100,
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
                    child:
                    IconButton(
                        icon: _load ? Image.file(imageFile) : Image.asset('assets/petFit.png', width: 150,),
                        iconSize: 150,
                        onPressed: () {
                          chooseImage(ImageSource.gallery);
                        },
                      )
                ),
                ///Space - 10
                const SizedBox(height: 10,),
                ///Pet details
                ListView.builder(
                    itemCount: productMap.length,
                    shrinkWrap:true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          constraints: const BoxConstraints(minHeight: 25),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: mediaQuery.size.width / 3.5,
                                    child:
                                    Text(getValue(index),style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(width: 10,),
                                //Text('Street Dog',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                Expanded(
                                  child: MyTextField(placeholder: getValue(index, isKey: false), onTapped: () {  },
                                    controller:  getController(index),
                                    errorText: getError(index) ? getErrorText(index): null,
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }),

                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () async {
                    setState(() {
                      _name.text.isEmpty?_validateName=true:_validateName=false;
                      _cost.text.isEmpty?_validateCost=true:_validateCost=false;
                      _url.text.isEmpty?_validateUrl=true:_validateUrl=false;
                      _stock.text.isEmpty?_validateStock=true:_validateStock=false;
                    });

                    if(!_validateName && !_validateCost && !_validateUrl && !_validateStock) {
                      //print('Data can be saved');
                      var product = Product();
                      product.name = _name.text;
                      product.price = int.parse(_cost.text);
                      product.image = _url.text;
                      product.quantity = int.parse(_stock.text);
                      var result = await _petService.saveProduct(product);
                      if (result != null) {
                        showAlert();
                      }
                    }

                  },
                  child: const SizedBox(
                    width: 100,
                    child: Text('ADD', textAlign: TextAlign.center,),
                  ),
                ),

                ///Space at top - 10
                const SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlert() {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            //insetPadding: EdgeInsets.symmetric(horizontal: 0),
            title: const Text("Alert"),
            content: const Text('New Product added successfully'),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: const Text('OK', style: TextStyle(color: Colors.teal),))
            ],
          );
        }).then((value) =>  Navigator.of(context).pop());
  }

}
