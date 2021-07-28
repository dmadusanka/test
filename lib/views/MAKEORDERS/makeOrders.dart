import 'package:MOrder/controllers/cart_controller.dart';
import 'package:MOrder/views/MAKEORDERS/signature_pad.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:flutter/material.dart';
import 'package:MOrder/views/MATERIAL/mainDrawer.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import 'package:MOrder/controllers/cart_controller.dart';
import 'package:MOrder/controllers/shopping_controller.dart';
import 'package:MOrder/views/CART/productRanges.dart';

class MakeOder extends StatefulWidget {
  @override
  _MakeOderState createState() => _MakeOderState();
}

class _MakeOderState extends State<MakeOder> {
  final shoppingController = Get.put(ShoppingController());
  final cartControllert = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return AllProductRanges();
            }));
          },
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          actions: <Widget>[
            Badge(
              position: BadgePosition.topEnd(top: 0, end: 3),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              badgeContent:GetX<CartController>(
                builder: (controller) {
                  return Text('${controller.itemCount}',
                    style: TextStyle(fontSize: 15, color: Colors.white),);
                },
              ),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white,),
                  // onPressed: () {
                  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  //     return MakeOder();
                  //   }));
                  // }
              ),
            )
          ],
          title: GetX<CartController>(
            builder: (controller) {
              return Text("Orders - \$ ${controller.totalPrice}");
            },
          ),
          backgroundColor: Colors.orange,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Current',
              ),
              Tab(
                text: 'Summary',
              )
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: TabBarView(
          children: [
            GetX<CartController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var unitPrice = controller.cartItems[index].price;
                          var Quantity = controller.cartItems[index].quantity;
                          var total = unitPrice * Quantity;
                          // return ListTile(
                          //   title:Text(controller.cartItems[index].productName),
                          //   subtitle: Row(
                          //     children: [
                          //       Text(total.toString()),
                          //       SizedBox(width: 20.0,),
                          //       Text(total.toString()),
                          //       SizedBox(width: 20.0,),
                          //       Text(total.toString())
                          //     ],
                          //   ),
                          //   // trailing: Column(
                          //   //   children: [
                          //   //     Text(controller.cartItems[index].price.toString()),
                          //   //     Text(controller.cartItems[index].price.toString()),
                          //   //     Text(controller.cartItems[index].price.toString())
                          //   //   ],
                          //   // ),
                          //   //controller.cartItems[index].price.toString()),
                          // );
                          return Container(
                            child: Card(
                              color: Colors.white,
                              elevation: 2.0,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(controller.cartItems[index].productName, style: TextStyle(fontSize: 20.0),),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Unit Price : ${controller.cartItems[index].price.toString()}",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.blue
                                          ),),
                                        const SizedBox(width: 8),
                                        Text("Quantity : ${controller.cartItems[index].quantity.toString()}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.purple
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text("Totoal : ${total.toString()}", style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.green
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.red),
                                          ),

                                          child: Text('Remove'),
                                          onPressed: () {
                                            cartControllert.removeProduct(controller.cartItems[index]);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: controller.cartItems.length,
                      ),
                    ),
                    GetX<CartController>(
                      builder: (controller) {
                        if(controller.itemCount == 0){
                          return Center(
                            child: Text(""),
                          );
                        }else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                          title: Center(
                                            child: Text("Sign For Confirm the order"),
                                          ),
                                          actions: [
                                            Center(
                                              child: SfSignaturePad(
                                                minimumStrokeWidth: 2,
                                                maximumStrokeWidth: 5,
                                                strokeColor: Colors.black,
                                                backgroundColor: Colors.black12,
                                              ),
                                            ),
                                            Center(
                                              child: ElevatedButton(
                                                child: Text('Done'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => SignaturePad(),
                                  //   ),
                                  // );
                                },
                                child: Text('Confirm Order')),
                          );
                        }
                      }
                    )
                  ],
                );
              },
            ),
            Container(
              child: Center(
                child: Text("There is no any summery Products."),
              ),
            )
          ],
        ),
      ),
    );
  }
}
