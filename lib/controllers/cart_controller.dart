import 'package:MOrder/models/product.dart';
import 'package:get/state_manager.dart';

class CartController extends GetxController{
  var cartItems = List<Product>().obs;
  int get itemCount => cartItems.length;
  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  addToCart(Product product){
    print(itemCount);
    if(!cartItems.any((element) => element.id == product.id)){
      cartItems.add(product);
      return;
    }
    var cartItem = cartItems.firstWhere((element) => element.id == product.id);
    print(itemCount);
    if(cartItem != null){
      if(cartItem.quantity != product.quantity){
        cartItem.quantity = product.quantity;
      }
    }
  }

}