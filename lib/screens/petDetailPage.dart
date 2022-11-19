import 'package:flutter/material.dart';

class PetDetailPage extends StatefulWidget {
  const PetDetailPage({Key? key}) : super(key: key);

  @override
  State<PetDetailPage> createState() => _PetDetailPageState();
}

class _PetDetailPageState extends State<PetDetailPage> {


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
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                            constraints: const BoxConstraints(minHeight: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                 Text('Pet name :',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                 SizedBox(width: 10,),
                                 Text('Street Dog',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
                          _buildTextField(),

                          ///Album
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Album',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              IconButton(onPressed: () {
                                print('pressed');
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
                                    print('create pressed');
                                  }, icon: const Icon(Icons.calendar_month_outlined)),
                                  Text('Create'),
                                ],
                              ),

                              Column(
                                children: [
                                  IconButton(onPressed: () {
                                    print('view pressed');
                                  }, icon: const Icon(Icons.view_timeline_outlined)),
                                  Text('View'),
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
                                  print('call pressed');
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
                                onPressed: () {
                                  print('delete pressed');
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

  Widget _buildTextField() {

    return const TextField(
      enabled: false,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 1,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "sdfasdfa dfasd asf asdlkfj asldfjal dflas;jfd laksdjflk ajsdflka dlkfjasldk jalsdfj alsdf laksdjflak jdsflka jsdlfkja lsdkfjlak sdjflaksd jasdkfj alksdfalkdsfj laksdjfl asf",
        border: InputBorder.none,
      ),
    );
  }
}
