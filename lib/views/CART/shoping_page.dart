import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:MOrder/controllers/cart_controller.dart';
import 'package:MOrder/controllers/shopping_controller.dart';
import 'package:MOrder/views/MAKEORDERS/makeOrders.dart';
import 'package:MOrder/models/product.dart';
import 'package:MOrder/views/MATERIAL/bottomBar.dart';
//import 'package:charts_flutter/flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShoppingPage extends StatelessWidget {
  final String categoryId;

  ShoppingPage(this.categoryId);

  final shoppingController = Get.put(ShoppingController());
  final cartControllert = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GetX<CartController>(
            builder: (controller) {
              return Text("\$ ${controller.totalPrice}");
            },
          ),
          backgroundColor: Colors.orange,
        ),
        //bottomNavigationBar: BottomBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add_shopping_cart_outlined,),
          label: GetX<CartController>(
            builder: (controller) {
              return Text('${controller.itemCount}',
                  style: TextStyle(fontSize: 20));
            },
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_){
                  return makeOder();
                }
            ));
            // showDialog(
            //   context: context,
            //   builder: (_) => AlertDialog(
            //     title: Container(
            //       padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
            //       color: Colors.amber,
            //       child: Center(
            //         child: Text("Ordered Items"),
            //       ),
            //     ),
            //     actions: [
            //       Container(
            //         width: 400,
            //         child: Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       )
            //     ],
            //   ),
            //);
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (_) {
            //   //return MainDashBoard(snapshot.data[index].id);
            //   return makeOder();
            // }));
          },
          backgroundColor: Colors.orange,
        ),
        body: FutureBuilder<List<Product>>(
          future: getProduct(categoryId),
          builder: (context, data) {
            if (data.hasData) {
              if (data.data.length == 0) {
                return Center(
                  child: Text('No Products for this Category'),
                );
              }
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                        itemCount: data.data.length,
                        itemBuilder: (context, index) {

                      var imageIMAGE = data.data[index].productImage;
                      var baseURL = 'https://demo.msalesapp.com/msales/resources/getBlob/';
                      var imageURL = baseURL+imageIMAGE;

                      // return Container(
                      //   margin: EdgeInsets.symmetric(
                      //     horizontal: 10.0,
                      //     //vertical: 2.0,
                      //   ),
                      //   //color: Colors.amber,
                      //   height: 120,
                      //   child: Stack(
                      //     alignment: Alignment.bottomCenter,
                      //     children: [
                      //       Container(
                      //         height: 100,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(2),
                      //           color: Colors.white54,
                      //             border: Border.all(color: Colors.black12)
                      //         ),
                      //       ),
                      //       Positioned(
                      //         top: 0,
                      //         right: 0,
                      //         child:Container(
                      //           padding: EdgeInsets.symmetric(horizontal: 10.0),
                      //           height: 100,
                      //           //width: 200,
                      //           child: Image.network(imageURL,),
                      //         )
                      //       ),
                      //       Positioned(
                      //           top: 85.0,
                      //           //left: 50.0,
                      //           right: -5,
                      //           child:Container(
                      //             padding: EdgeInsets.symmetric(horizontal: 10.0),
                      //             height: 30,
                      //             //width: 200,
                      //             //child: Text("TEMP")
                      //             child: Container(
                      //               padding: EdgeInsets.symmetric(
                      //                 horizontal: 30,
                      //                 vertical: 5.0,
                      //               ),
                      //               decoration: BoxDecoration(
                      //                   color: Colors.orange,
                      //                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(22), topLeft: Radius.circular(22))
                      //               ),
                      //               child: Text(
                      //                 data.data[index].price.toString(),
                      //                 style: TextStyle(
                      //                   color: Colors.black,
                      //                   fontSize: 18.0
                      //                 ),
                      //               ),
                      //             ),
                      //           )
                      //       ),
                      //       Positioned(
                      //         bottom: 0,
                      //         left: 0,
                      //         child: SizedBox(
                      //           width: MediaQuery.of(context).size.width-210,
                      //           height: 90,
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //            children: [
                      //              Center(
                      //                child: Text(data.data[index].productName, style: TextStyle(fontSize: 16.0, color: Colors.black),),
                      //              ),
                      //              Expanded(
                      //                child: ChangeNumber((quantity){
                      //                  data.data[index].quantity = quantity;
                      //                }),
                      //              ),
                      //              ElevatedButton(
                      //                onPressed: () {
                      //                  cartControllert.addToCart(data.data[index]);
                      //                },
                      //                style: ElevatedButton.styleFrom(
                      //                  primary: Colors.black12, // background
                      //                  onPrimary: Colors.white, // foreground
                      //                ),
                      //                child: Text("Add To Cart"),
                      //              ),
                      //            ],
                      //           ),
                      //         )
                      //       ),
                      //     ],
                      //   ),
                      // );

                      return Card(
                        margin: EdgeInsets.all(12),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          //padding: EdgeInsets.all(10.0),
                                          //color: Colors.orangeAccent,
                                          child: Text('${data.data[index].productName}',
                                            style: TextStyle(fontSize: 18.0, color: Colors.orangeAccent),
                                          ),
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text(
                                            '${data.data[index].productDescription}'
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text(
                                          '\$ ${data.data[index].price}',
                                          style: TextStyle(fontSize: 18.0,),
                                        ),
                                        ChangeNumber((quantity){
                                          data.data[index].quantity = quantity;
                                        }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Image.network(imageURL, height: 100,),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cartControllert.addToCart(data.data[index]);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black12, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                child: Text("Add To Cart"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
                  // Text("Total Amount \$"),
                  // SizedBox(height: 50.0,)
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Future<List<Product>> getProduct(String categoryId) async {
    final List<Product> products = [];

    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkJEU2pBYnRPYWhFMEQtSjFmTXZ6MyJ9.eyJodHRwczovL3d3dy5tc2FsZXMuY29tL2VtYWlsIjoiZHVsYW5qYW5zZWpAZ21haWwuY29tIiwiaHR0cHM6Ly93d3cubXNhbGVzLmNvbS9lbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tLyIsInN1YiI6ImF1dGgwfDYwNzAwYzgyMGE0YjU1MDA2OTJkYjgyOSIsImF1ZCI6WyJodHRwOi8vcHVibGljLmFwaS5tc2FsZXNhcHAuY29tIiwiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTYyNzAxNDgyMSwiZXhwIjoxNjI3MTAxMjIxLCJhenAiOiJCN0ZObXV2ZVRjZG4zZWthcVQ3eU1PZUs0Szgwd1FpOCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwifQ.RmlpNB1UlsKXAmZBzqd7yXHBxYnuw9EVTcBT_oNOPl1HnbV7Qya9v2BwYF0IvkTZk5YUphBqSf_3tTphgAQsD01XAzOgpez-QyefnDeigQTq06CLxZmjn7fWx284B9rbM1H7Gdujj0TEDCo8ET2c3acTN9u-_x-QXW4sVfeCuhLX7pDwWM7voQG_2Dsc6z1TYbVPydAbglEBxA_O7LF-_qyC1v0dPEeRuzyVel4VHe5Gs4MmhP6Vr3DDiL91ams9D5h8Eex7VTP7cDomQq9YAmUG0vy6vBFBCyDf2i0ykbnH3aL0I2VuCxPjAQ6vsANPIumqkLzW4Fmar9ThXpU5IA',
      'Content-Type': 'application/json',
      'Cookie': 'JSESSIONID=B2E911507B6EE95774EC0246B10F5F5F',
      'BusinessId': 'partner-1'
    };

    var response = await http.get(
        Uri.parse(
            'https://api.msalesapp.com/API/V1/Products?CategoryId=$categoryId'),
        headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var allProducts = json.decode(response.body)["products"];
      print(allProducts);

      for (int i = 0; i < allProducts.length; i++) {
        products.add(Product.fromJson(allProducts[i]));
      }
    } else {
      print(response.reasonPhrase);
    }
    print(products.length);
    return products;
  }

  void getQuantity(int quantity){

  }
}


class ChangeNumber extends StatefulWidget {

  final Function newCount;
  ChangeNumber(this.newCount);

  @override
  State<StatefulWidget> createState() {
    return _ChangeNumber();
  }
}

class _ChangeNumber extends State<ChangeNumber> {
  int _counter = 1;
  @override
  Widget build(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              if (_counter > 1) {
                setState(() {
                  _counter--;
                });
                widget.newCount(_counter);
              }
            },
            icon: Icon(Icons.remove),
          ),
          Text(_counter.toString()),
          IconButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
              widget.newCount(_counter);
            },
            icon: Icon(Icons.add),
          ),
        ],
      );
  }
}
