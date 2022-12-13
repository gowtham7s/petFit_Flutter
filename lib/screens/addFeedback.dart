
import 'package:flutter/material.dart';
import 'package:pet_fit/database/petServices.dart';
import 'package:pet_fit/screens/additionalWidgets.dart';
import 'dart:core';
import 'package:pet_fit/Model/Pet.dart';

class AddFeedbackPage extends StatefulWidget {
  const AddFeedbackPage({Key? key}) : super(key: key);

  @override
  State<AddFeedbackPage> createState() => _AddFeedbackPageState();
}

class _AddFeedbackPageState extends State<AddFeedbackPage> {

  final _petService = PetServices();

  final TextEditingController _feedback = TextEditingController();
  late var validateExpression = "";
  late var validateCategory = "";
  late var validateFeedback = false ;
  late var validateError = false ;

  String getErrorText() {
    if (validateExpression == '') {
      return "Select feel about the feature";
    } else if (validateCategory == '') {
      return "Select feel about the category";
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
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
                    child: Image.asset('assets/petFit.png', width: 150,)
                ),
                ///Space - 10
                const SizedBox(height: 10,),

                ///Owner details
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Welcome New User ',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),textAlign: TextAlign.start,),

                      ///Space 10
                      const SizedBox(height: 8,),

                      const Text('We would like your feedback to improve our app',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),textAlign: TextAlign.start,),

                      ///Space 10
                      const SizedBox(height: 10,),

                      const Text('How do you feel about the feature of the app',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal,),textAlign: TextAlign.start,),

                      ///Space 10
                      //const SizedBox(height: 10,),

                      Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 70,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.white
                      ),
                      //color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          SizedBox(
                            //size: const Size(70, 56),
                            height: 56, width: 70,
                            child: InkWell(
                              //splashColor: Colors.green,
                              onTap: () {
                                setState(() {
                                  validateExpression = 'Very dissatisfied';
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(child:
                                  FittedBox(fit: BoxFit.fill,child: Icon(Icons.face_retouching_natural_outlined, color: validateExpression == 'Very dissatisfied' ? Colors.red : Colors.black,),)
                                  ), // <-- Icon
                                  const Text("Very dissatisfied", style: TextStyle(fontSize: 9),), // <-- Text
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            //size: const Size(70, 56),
                            height: 56, width: 70,
                            child: InkWell(
                              splashColor: Colors.green,
                              onTap: () {
                                setState(() {
                                  validateExpression = 'Dissatisfied';
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(child:
                                  FittedBox(fit: BoxFit.fill,child: Icon(Icons.tag_faces_outlined, color: validateExpression == 'Dissatisfied' ? Colors.orange : Colors.black,),)
                                  ), // <-- Icon
                                  const Text("Dissatisfied", style: TextStyle(fontSize: 9),), // <-- Text
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            //size: const Size(70, 56),
                            height: 56, width: 70,
                            child: InkWell(
                              splashColor: Colors.green,
                              onTap: () {
                                setState(() {
                                  validateExpression = 'Average';
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(child:
                                  FittedBox(fit: BoxFit.fill,child: Icon(Icons.face_retouching_natural_outlined, color: validateExpression == 'Average' ? Colors.yellow : Colors.black,),)
                                  ), // <-- Icon
                                  const Text("Average", style: TextStyle(fontSize: 9),), // <-- Text
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            //size: const Size(70, 56),
                            height: 56, width: 70,
                            child: InkWell(
                              splashColor: Colors.green,
                              onTap: () {
                                setState(() {
                                  validateExpression = 'Satisfied';
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(child:
                                  FittedBox(fit: BoxFit.fill,child: Icon(Icons.tag_faces_rounded, color: validateExpression == 'Satisfied' ? Colors.greenAccent : Colors.black,),)
                                  ), // <-- Icon
                                  const Text("Satisfied", style: TextStyle(fontSize: 9),), // <-- Text
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            //size: const Size(70, 56),
                            height: 56, width: 70,
                            child: InkWell(
                              splashColor: Colors.green,
                              onTap: () {
                                setState(() {
                                  validateExpression = 'Very satisfied';
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child:
                                  FittedBox(fit: BoxFit.fill,child: Icon(Icons.tag_faces_rounded, color: validateExpression == 'Very satisfied' ? Colors.green : Colors.black,),)
                                  ), // <-- Icon
                                  const Text("Very satisfied", style: TextStyle(fontSize: 9),), // <-- Text
                                ],
                              ),
                            ),
                          ),

                          // CustomButton(name: "Select Video", iconName: Icons.video_call_rounded, onPressed: (){
                          //   print('Pressed take photo');
                          // })

                        ],
                      ),
                    ),
                  ),


                      const Text('Please select any feedback category',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),

                      ///Space 10
                      const SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all( validateCategory == 'SUGGESTIONS' ? Colors.deepPurpleAccent : Colors.black),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                validateCategory = 'SUGGESTIONS';
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              width: mediaQuery.size.width / 4,
                              child: const Text('SUGGESTIONS', textAlign: TextAlign.center,style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(validateCategory == 'COMPLAINTS' ? Colors.deepPurpleAccent : Colors.black),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                validateCategory = 'COMPLAINTS';
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              width: mediaQuery.size.width / 4,
                              child: const Text('COMPLAINTS', textAlign: TextAlign.center,style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),),
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(validateCategory == 'COMPLEMENTS' ? Colors.deepPurpleAccent : Colors.black),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                validateCategory = 'COMPLEMENTS';
                              });

                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              width: mediaQuery.size.width / 4,
                              child: const Text('COMPLEMENTS', textAlign: TextAlign.center,style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
                            ),
                          ),
                        ],
                      ),

                      ///Space 10
                      const SizedBox(height: 15,),

                      ///Owner Details title
                      const Text('Please leave your feedback below.',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),

                      ///Space 10
                      const SizedBox(height: 5,),

                      ///Owner details text
                      MyTextField2(
                        controller: _feedback,
                        placeholder: 'Enter your feedback',
                        onTapped: (){ },
                        errorText: validateFeedback ? getErrorText() == '' ? 'Please enter your feedback' : null : null,
                      ),

                      const SizedBox(height: 8,),

                      Text(validateError ? getErrorText() : '',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.red),textAlign: TextAlign.center,),

                      const SizedBox(height: 5,),

                      ///Buttons - Add
                      Center(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: () async {
                            setState(() {
                              validateExpression == ''?validateError=true:validateError=false;
                              validateCategory == ''?validateError=true:validateError=false;
                              _feedback.text.isEmpty?validateFeedback=true:validateFeedback=false;
                            });


                            if (validateExpression != '' && validateCategory != '' && _feedback.text.isNotEmpty) {
                                var feedback = Feedbacks();
                                feedback.expression = validateExpression;
                                feedback.category = validateCategory;
                                feedback.feedback = _feedback.text;
                                var result = await _petService.saveFeedback(feedback);
                                if (result != null) {
                                  showAlert();
                                }
                            } 
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            width: mediaQuery.size.width / 5,
                            child: const Text('Send', textAlign: TextAlign.center,style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                          ),
                        ),
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

  showAlert() {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            //insetPadding: EdgeInsets.symmetric(horizontal: 0),
            title: const Text("Thank you!!!"),
            content: const Text('We thankyou for your feedback. We will get back to you soon'),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: const Text('OK', style: TextStyle(color: Colors.teal),))
            ],
          );
        }).then((value) =>  Navigator.of(context).pop());
  }

}