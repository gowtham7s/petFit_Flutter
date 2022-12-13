import 'package:flutter/material.dart';
import 'package:pet_fit/Model/Pet.dart';
import 'package:pet_fit/database/petServices.dart';

class ViewFeedbackPage extends StatefulWidget {
  const ViewFeedbackPage({Key? key}) : super(key: key);

  @override
  State<ViewFeedbackPage> createState() => _ViewFeedbackPageState();
}

class _ViewFeedbackPageState extends State<ViewFeedbackPage> {

  late List<Feedbacks> _feedbackList =  <Feedbacks>[];
  final _petService = PetServices();

  getAllFeedbacks() async {
    var feedbacks = await _petService.readAllFeedbacks();
    _feedbackList = [];
    feedbacks.forEach((feedback){
      var feedbackModel = Feedbacks();
      feedbackModel.id = feedback['id'];
      feedbackModel.expression = feedback['expression'];
      feedbackModel.category = feedback['category'];
      feedbackModel.feedback = feedback['feedback'];
      _feedbackList.add(feedbackModel);
    });
  }

  @override
  void initState() {
    getAllFeedbacks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Feedback'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: FutureBuilder(
        future: getAllFeedbacks(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/wallpaper.webp"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(8),
          //color: Colors.red,
          child: ListView.separated(
            //itemExtent: 70,
            //shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => Container(height: 1, color: Colors.red,),
            itemBuilder: (context, index){
              final id = index + 1;
              return Container(
                  // decoration: const BoxDecoration( //                    <-- BoxDecoration
                  //   border: Border(bottom: BorderSide(),
                  //   ),
                  // ),
                padding: const EdgeInsets.symmetric(vertical: 4),
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Feedback given by Guest$id :", style: const TextStyle(
                      color: Colors.white,
                    )),

                    Text(_feedbackList[index].expression!, style: const TextStyle(
                      color: Colors.white,
                    )),

                    Text('${_feedbackList[index].category!} : ${_feedbackList[index].feedback!}', style: const TextStyle(
                      color: Colors.white,
                    )),
                    // Container(
                    //   height: 1,
                    //   color: Colors.red,
                    // )
                  ].map((e) => Padding(padding: const EdgeInsets.all(4),
                  child: e,)).toList(),
                )
              );
            },itemCount: _feedbackList.length,
          ),

        ); }
      ),
    );
  }
}

