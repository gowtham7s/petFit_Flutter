import 'package:flutter/material.dart';
import 'package:pet_fit/screens/ProductNavDrawer.dart';
import 'package:pet_fit/database/petServices.dart';
import 'package:pet_fit/Model/Pet.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({Key? key}) : super(key: key);

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {

  late List<Product> _productList =  <Product>[];
  final _petService = PetServices();

  Future<void> getAllProducts() async {
    var products = await _petService.readAllProducts();
    _productList = [];
    products.forEach((product){
      var productModel = Product();
      productModel.id = product['id'];
      productModel.name = product['name'];
      productModel.image = product['image'];
      productModel.price = product['price'];
      productModel.quantity = product['quantity'];
      _productList.add(productModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getAllProducts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  const Padding(
          padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: ProductNavigationDrawer(),),
        appBar: AppBar(
          title: const Text('Products'),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey,
          body: FutureBuilder(
          //future: getAllProducts(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            return RefreshIndicator(
                onRefresh: getAllProducts,
              child: ListView.builder(
                //itemExtent: 70,
                //shrinkWrap: true,
                itemBuilder: (context, index) {
                  final id = index + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: ListTile(
                      dense: true,
                      leading: const SizedBox(
                        //width: 50,
                        // height: 80,
                          child: Image(image: AssetImage('assets/petFit.png'),)
                      ),
                      title: Text("$id. ${_productList[index].name!} \n\₹ ${_productList[index].price!}"),
                      subtitle: Text('Quantity: ${_productList[index].quantity!}', style: const TextStyle(
                        color: Colors.black,
                      ),),
                      trailing: IconButton(onPressed: () {
                        showDialog(context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              //set up the buttons
                              Widget cancelButton = TextButton(
                                child: const Text(
                                  "CANCEL", style: TextStyle(color: Colors.teal),),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              );
                              Widget okButton = TextButton(
                                child: const Text(
                                  "OK", style: TextStyle(color: Colors.teal),),
                                onPressed: () async {
                                  var result = await _petService.removeProduct(_productList[index].id!);
                                  if (result != null) {
                                    //showAlert();
                                    setState(() {
                                      getAllProducts();
                                    });
                                    Navigator.of(context).pop();
                                  }
                                },
                              );

                              return AlertDialog(
                                title: const Text("Confirm Delete"),
                                content: const Text(
                                    'This product will be deleted forever'),
                                actions: [
                                  cancelButton,
                                  okButton,
                                ],
                              );
                            });
                      }, icon: const Icon(Icons.delete_forever),

                      ),
                      tileColor: Colors.white,
                    ),
                  );
                }, itemCount: _productList.length,
              ),
            );
          }
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
            content: const Text('Product deleted successfully'),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: const Text('OK', style: TextStyle(color: Colors.teal),))
            ],
          );
        });
  }
}
