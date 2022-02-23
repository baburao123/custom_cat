import 'package:flutter/material.dart';

import './../model/product_info.dart';
import './../model/cart_product_info.dart';

class UserCartHandlerProvider with ChangeNotifier {
  List<CartProductInfo> products = [];


  int get noOfItemsInCart{

    if(isCartNotEmpty){
      return products.length;
    }
    return 0 ;

  }

  bool get isCartNotEmpty {
    return products != null && products.isNotEmpty ;
  }

  double get total {
    return products.fold(0.0, (double currentTotal, CartProductInfo nextProduct) {
      return currentTotal + nextProduct.productTotalPrice();
    });
  }

  void addToCart(Product product) {
    print("--> product:${product.id}");

    if (products.isNotEmpty) {
      var temp = products.firstWhere((element) => element.proId == product.id, orElse: () => null);

      print("--->temp:$temp");
      if(temp != null ){
        temp.addProduct();
        return;
      }
    }
    print("--> not found so added");
    products.add(CartProductInfo(proId: product.id.toString(), qty: 1, product: product));
    notifyListeners();
    return ;
  }

  void removeFromCart(Product product) {
    var temp = products.firstWhere((element) => element.proId == product.id.toString(), orElse: () => null);
    if(temp != null){
      if(temp.qty > 1){
        temp.removeProduct() ;
      }else{
        products.remove(temp);
      }
      notifyListeners();
      return ;
    }
    //products.remove(product);
    notifyListeners();
  }

}