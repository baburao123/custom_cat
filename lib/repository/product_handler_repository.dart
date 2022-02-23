import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './../model/product_info.dart';
import './../model/category_info.dart';

import './../utility/master_lib.dart' show readJsonAsStringFromAssets;

class ProductHandlerRepository{
  bool readLocalFile = true ;

  Future<List<Product>> getProductInfoList() async{
    if (readLocalFile){
      //print(await readJsonAsStringFromAssets("assets/dummy_data/hs_dummy_data_product_list.json"));
      List<dynamic>  resp = jsonDecode(await readJsonAsStringFromAssets("https://mocki.io/v1/9598715b-2a0b-4f27-b249-806240828aec"));
      return Product.getListFromJson(resp);
    }

    return Future.value(<Product>[]);
  }


  Future<List<Category>> getCategoryInfoList() async{
    if (readLocalFile){
      //print(await readJsonAsStringFromAssets("assets/dummy_data/hs_dummy_data_product_list.json"));
      List<dynamic>  resp = jsonDecode(await readJsonAsStringFromAssets("https://mocki.io/v1/9598715b-2a0b-4f27-b249-806240828aec"));
      return Category.getListFromJson(resp);
    }
    return Future.value(<Category>[]);
  }

  Future<List<Product>> getProductInfoListV2() async{



    var response = await http.get(
      Uri.parse("https://mocki.io/v1/9598715b-2a0b-4f27-b249-806240828aec"),

    );
    log("GET_SALE_INFO_URL: ${response.body}");
    if (response.statusCode == 200) {
      try {
        var resp = jsonDecode(response.body);
        print("----?${resp["data"]}",);
        return Product.getListFromJson(resp["data"]);
      } catch (e) {
        print(e);
        throw "Error";
      }
    } else {
      throw "Error";
    }
  }


}