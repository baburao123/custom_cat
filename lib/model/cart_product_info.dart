import 'package:flutter/cupertino.dart';

import 'product_info.dart';

class CartProductInfo{
  String proId;
  int qty;
  Product product;

  CartProductInfo({@required this.proId, @required this.qty, @required this.product});

  bool addProduct(){
    qty += 1 ;
    return true ;
  }

  bool removeProduct(){
    if(qty <= 0 ){
      return false ;
    }
    qty -= 1 ;
    return true ;
  }

  double productTotalPrice(){
    return product.proPrice * qty ;
  }
}