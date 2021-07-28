import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:MOrder/views/CART/shoping_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import 'package:MOrder/controllers/cart_controller.dart';
import 'package:MOrder/controllers/shopping_controller.dart';
import 'package:MOrder/views/MAKEORDERS/makeOrders.dart';

class AllProductRanges extends StatefulWidget {
  @override
  _AllProductRangesState createState() => _AllProductRangesState();
}

class _AllProductRangesState extends State<AllProductRanges> {
  final shoppingController = Get.put(ShoppingController());
  final cartControllert = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return MakeOder();
                    }));
                  }
              ),
            )
          ],
          title: GetX<CartController>(
            builder: (controller) {
              return Text("\$ ${controller.totalPrice}");
            },
          ),
          backgroundColor: Colors.orange,
        ),
        body: FutureBuilder<List<ProductCategories>>(
          future: getProductCategories(),
          builder: (context, data) {
            if (data.hasData) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.orange)),
                          height: 120,
                          width: 160,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/promo.png',
                                height: 80.0,
                              ),
                              Text(
                                "Promotions",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 18.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.orange)),
                          height: 120,
                          width: 160,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/favorite.png',
                                height: 80.0,
                              ),
                              Text(
                                "Favorites",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        //crossAxisSpacing: 8,
                        itemBuilder: (context, index) {
                          var imageIMAGE = data.data[index].categoryImage;
                          var baseURL =
                              'https://demo.msalesapp.com/msales/resources/getBlob/';
                          var imageURL = baseURL + imageIMAGE;

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                // return mainDashBoard(newValue.id.toString());
                                return ShoppingPage(data.data[index].id);
                              }));
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.orange)),
                              //child: Text(data.data[index].name),
                              child: Center(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    imageURL,
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    data.data[index].name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                  ),
                                ],
                              )),
                            ),
                          );
                        },
                        itemCount: data.data.length,
                        staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
                  )
                ],
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Future<List<ProductCategories>> getProductCategories() async {
    final List<ProductCategories> productCategories = [];

    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkJEU2pBYnRPYWhFMEQtSjFmTXZ6MyJ9.eyJodHRwczovL3d3dy5tc2FsZXMuY29tL2VtYWlsIjoiZHVsYW5qYW5zZWpAZ21haWwuY29tIiwiaHR0cHM6Ly93d3cubXNhbGVzLmNvbS9lbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tLyIsInN1YiI6ImF1dGgwfDYwNzAwYzgyMGE0YjU1MDA2OTJkYjgyOSIsImF1ZCI6WyJodHRwOi8vcHVibGljLmFwaS5tc2FsZXNhcHAuY29tIiwiaHR0cHM6Ly9tc2FsZXMuYXUuYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTYyNzQ4OTQxMSwiZXhwIjoxNjI3NTc1ODExLCJhenAiOiJCN0ZObXV2ZVRjZG4zZWthcVQ3eU1PZUs0Szgwd1FpOCIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwifQ.m_rdR7mTXAfP0w3VR6XW1YIFqKqsurTBuAG2YUfMi3q-lnGk_PbwEGpQTGkQwteXLlJ0x0eXZ0cp9vU-Kt5rDfCUrOmSAVzZFE5j9IGv-8QkBlDn_w3H-7Jwl3nSA7lldAAJN1eIZ2dv-2cHOFeYBKdLBye6WN27wez0XAaLWHIkCT3LCIdKPWgwFGfgwsHwLlK_fUK7ySl0Amd6FnPb26N7BigGt1iGlzaCZP9MpeFVx3JStVs6JISwKxULvRDgB5iZPrSKrn6pF2jBlSR5uP1Wm5PQfWgJYp-jFrddGaCORWvYy_sjjF1ybqcH7PmnBm7OetqiLXfFDDNJiV2FTw',
      'Content-Type': 'application/json',
      'Cookie': 'JSESSIONID=B2E911507B6EE95774EC0246B10F5F5F',
      'BusinessId': 'partner-1'
    };

    var response = await http.get(
        Uri.parse('https://api.msalesapp.com/API/V1/ProductCategories'),
        headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var allProductCategories =
          json.decode(response.body)["productCategories"];
      print(allProductCategories);

      for (int i = 0; i < allProductCategories.length; i++) {
        productCategories
            .add(ProductCategories.fromJson(allProductCategories[i]));
      }
    } else {
      print(response.reasonPhrase);
    }
    print(productCategories.length);
    return productCategories;
  }
}

class ProductCategories {
  final String id;
  final String name;
  final String categoryImage;

  ProductCategories(this.id, this.name, this.categoryImage);

  factory ProductCategories.fromJson(Map<String, dynamic> json) {
    return ProductCategories(json['id'], json['name'], json['categoryImage']);
  }
}
