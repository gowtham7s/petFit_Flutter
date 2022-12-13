import 'package:flutter/material.dart';
import 'package:pet_fit/Model/Pet.dart';
import 'package:pet_fit/database/petServices.dart';

class ViewSchedulePage extends StatefulWidget {
  final int id;
  const ViewSchedulePage({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewSchedulePage> createState() => _ViewSchedulePageState();
}

class _ViewSchedulePageState extends State<ViewSchedulePage> {

  late List<Schedule> _scheduleList =  <Schedule>[];
  final _petService = PetServices();

  Future<void> getAllSchedules() async {
    var products = await _petService.readAllSchedules(widget.id);
      _scheduleList = [];
      products.forEach((product){
      var scheduleModel = Schedule();
      scheduleModel.id = product['id'];
      scheduleModel.name = product['name'];
      scheduleModel.whenDate = product['whenDate'];
      scheduleModel.notes = product['notes'];
      scheduleModel.petId = product['petId'];
      _scheduleList.add(scheduleModel);
     });
  }

  @override
  void initState() {
    getAllSchedules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View scheduled Activities'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: FutureBuilder(
        future: getAllSchedules(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return ListView.builder(
            //itemExtent: 70,
            //shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: ListTile(
                  title: Text("${_scheduleList[index].name} \n ${_scheduleList[index].whenDate}"),
                  subtitle: Text(
                    '${_scheduleList[index].notes}', style: const TextStyle(
                    color: Colors.black,
                  ),),
                  trailing: IconButton(onPressed: () {

                    showDialog(context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          //set up the buttons
                          Widget cancelButton = TextButton(
                            child: const Text("CANCEL", style: TextStyle(color: Colors.teal),),
                            onPressed:  () {
                              Navigator.of(context).pop();
                            },
                          );
                          Widget okButton = TextButton(
                            child: const Text("OK", style: TextStyle(color: Colors.teal),),
                            onPressed:  () async {
                              //print('item $id Deleted');
                              var result = await _petService.removeSchedule(_scheduleList[index].id!);
                              if (result != null) {
                                setState(() {
                                  getAllSchedules();
                                });
                                Navigator.of(context).pop();
                              }
                            },
                          );

                          return AlertDialog(
                            title: const Text("Confirm Delete"),
                            content: const Text('This schedule will be deleted forever'),
                            actions: [
                              cancelButton,
                              okButton,
                            ],
                          );
                        });
                  }, icon: const Icon(Icons.delete_forever),

                  ),
                  tileColor: Colors.white70,
                ),
              );
            }, itemCount: _scheduleList.length,
          );
        }
      ),
    );
  }
}
