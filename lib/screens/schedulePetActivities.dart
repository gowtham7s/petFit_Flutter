import 'package:flutter/material.dart';
import 'package:pet_fit/database/petServices.dart';
import 'package:pet_fit/screens/additionalWidgets.dart';
import 'dart:core';
import 'package:date_format/date_format.dart';
import 'package:pet_fit/screens/viewSchedule.dart';
import 'package:pet_fit/Model/Pet.dart';

class SchedulePetPage extends StatefulWidget {
  const SchedulePetPage({Key? key, required this.petDetail}) : super(key: key);

  final Pet petDetail;

  @override
  State<SchedulePetPage> createState() => _SchedulePetPageState();
}

class _SchedulePetPageState extends State<SchedulePetPage> {

  List<String> list = ['Activity: ', 'When: '];
  List<String> placeholderList = ['Enter Activity', 'When'];
  final _petService = PetServices();

  final TextEditingController _activity = TextEditingController();
  final TextEditingController _when = TextEditingController();
  final TextEditingController _notes = TextEditingController();

  bool _validateActivity = false;
  bool _validateWhen = false;
  bool _validateNotes = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule pet's Activities"),
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
                ///Space at top - 30
                const SizedBox(height: 30,),

                ///Two fields - Activity and When
                ListView.builder(
                    itemCount: 2,
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
                                Expanded( flex: 1,
                                    child: Text(list[index],style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                                const SizedBox(width: 10,),
                                //Text('Street Dog',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                Expanded(
                                  flex: 3,
                                  child: MyTextField(controller : (index == 0) ? _activity : _when,
                                    placeholder: placeholderList[index], onTapped: () async {
                                    if (index == 1) {
                                      ///Display Date Picker
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context, //context of current state
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                          lastDate:  DateTime(2023),
                                      );

                                      if(pickedDate != null ){
                                        //print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate = formatDate(pickedDate, [D,' ',M,' ',dd,' ',yyyy]); // DateFormat('yyyy-MM-dd').format(pickedDate);
                                        //print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                        _when.text = formattedDate;
                                      }
                                      // else{
                                      //   print("Date is not selected");
                                      // }
                                    }
                                  },
                                    errorText: (index == 0) ? _validateActivity ? "Activity can't be empty" : null : _validateWhen ? "Please choose the date" : null,
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }),

                ///Space at top - 10
               // const SizedBox(height: 10,),
                ///Notes and Add Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Notes
                      const Text('Notes: ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      ///Space 10
                      const SizedBox(height: 10,),
                      ///Owner details text
                      MyTextField2(
                        controller: _notes,
                        placeholder: 'Notes',
                        onTapped: (){ },
                        errorText: _validateNotes ? "Notes can't be empty" : null,
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
                              _activity.text.isEmpty?_validateActivity=true:_validateActivity=false;
                              _when.text.isEmpty?_validateWhen=true:_validateWhen=false;
                              _notes.text.isEmpty?_validateNotes=true:_validateNotes=false;
                              });

                              if(!_validateActivity && !_validateWhen && !_validateNotes) {

                                var schedule = Schedule();
                                schedule.name = _activity.text;
                                schedule.whenDate = _when.text;
                                schedule.notes = _notes.text;
                                schedule.petId = widget.petDetail.id;
                                var result = await _petService.saveSchedule(schedule);
                                if (result != null) {
                                    showDialog(context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context){
                                          return AlertDialog(
                                            //insetPadding: EdgeInsets.symmetric(horizontal: 0),
                                            title: const Text("Alert"),
                                            content: const Text('Scheduled your activity'),
                                            actions: [
                                              TextButton(onPressed: () {
                                                //Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ViewSchedulePage(id: widget.petDetail.id!,)));
                                              }, child: const Text('OK'))
                                            ],
                                          );
                                        }).then((value) => Navigator.of(context).pop());

                                }

                              }

                            },
                            child: SizedBox(
                              width: mediaQuery.size.width / 3,
                              child: const Text('Add Activity', textAlign: TextAlign.center,),
                            ),
                          ),
                        ],
                      ),
                    ],
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

}
