import 'package:MOrder/views/CART/shoping_page.dart';
import 'package:MOrder/views/AUTH/login.dart';
import 'package:flutter/material.dart';
import 'package:MOrder/views/ORDERS/todayOrders.dart';
import 'package:MOrder/views/OUTSTANDING/outsStanding.dart';
import 'package:MOrder/views/PRODUCTSCATERGORY/produtCatergory.dart';
import 'package:MOrder/views/INVOICE/invoiceSetlement.dart';
import 'package:MOrder/views/MAKEORDERS/makeOrders.dart';
import 'package:MOrder/views/PRODUCTS/productCategory.dart';
import 'package:MOrder/views/CART/productRanges.dart';
import 'package:MOrder/views/DASHBOARD/mainDashboard.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(30.0), color: Colors.orange,
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage('https://s.gravatar.com/avatar/66cb0e36c3955fcc2e0480a012436a4f?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fdm.png')),
                  ),
                ),
                Text("Dulanjan Madusanka",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                Text("dulanjansej@gmail.com",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.orange,),
            title: Text("Dashboard",
              style: TextStyle(fontSize: 16),),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    //return mainDashBoard("cat");
                    return MainDashBoard(1);
                  }
              ))
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.speaker_notes_outlined),
          //   title: Text("Loyalty Card", style: TextStyle(fontSize: 16),),
          //   onTap: () => {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (_){
          //           return LoyatyCard();
          //         }
          //     ))
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.speaker_notes_outlined, color: Colors.orange,),
            title: Text("Orders", style: TextStyle(fontSize: 16),),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return makeOder();
                  }
              ))
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.sticky_note_2_outlined, color: Colors.orange,),
          //   title: Text("Today's Oder History", style: TextStyle(fontSize: 16),),
          //   onTap: () => {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (_){
          //           return todaysOrders();
          //         }
          //     ))
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.monetization_on_sharp, color: Colors.orange,),
            title: Text("Outstanding",
              style: TextStyle(fontSize: 16),),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return outStanding();
                  }
              ))
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.add_shopping_cart),
          //   title: Text("Products",
          //     style: TextStyle(fontSize: 16),),
          //   onTap: () => {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (_){
          //           return mainCategory();
          //         }
          //     ))
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.add_shopping_cart),
          //   title: Text("Products 2",
          //     style: TextStyle(fontSize: 16),),
          //   onTap: () => {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (_){
          //           return productRangers();
          //         }
          //     ))
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart, color: Colors.orange,),
            title: Text("Products",
              style: TextStyle(fontSize: 16),),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    //return ShoppingPage();
                    return AllProductRanges();
                  }
              ))
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red,),
            title: Text("Logout",
              style: TextStyle(fontSize: 16),),
            onTap: () => {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (_){
              //       return Login("","");
              //     }
              // ))
            },
          ),
        ],
      ),
    );
  }
}
