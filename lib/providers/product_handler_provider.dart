import 'package:flutter/material.dart';

//Model
import './../model/product_info.dart';
import './../model/category_info.dart';

//Repository
import './../repository/product_handler_repository.dart';

class ProductHandlerProvider with ChangeNotifier{
  Future<List<Product>> fetchAllProductList() async {
    try {
      ProductHandlerRepository repo = ProductHandlerRepository();
      final resp = await repo.getProductInfoListV2();
      resp.forEach((element) {
        print("${element.name}: ${element.id}" );
      });
      return resp;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Category>> fetchAllCategories() async {
    try {
      ProductHandlerRepository repo = ProductHandlerRepository();
      final resp = await repo.getCategoryInfoList();
      resp.forEach((element) {
        print("${element.categoryTitle}: ${element.categoryId}" );
      });
      return resp;
    } catch (e) {
      print(e);
      throw e;
    }
  }

}