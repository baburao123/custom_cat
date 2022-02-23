import 'package:flutter/material.dart';

import './../model/product_info.dart';

class CartProductItemViewWidget extends StatelessWidget {
  final Product mProduct;
  final Function mOnClickCallbackAction;

  const CartProductItemViewWidget({Key key, this.mProduct, this.mOnClickCallbackAction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=> mOnClickCallbackAction(action:"Click"),
      leading: Icon(Icons.category),
      title: Text(mProduct.name),
     // subtitle: Text(mProduct.description),
      trailing: Text(mProduct.proPrice.toString()),
    );
  }
}
