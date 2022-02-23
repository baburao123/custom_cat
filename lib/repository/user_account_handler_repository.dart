import 'dart:convert';
import 'package:CatelogApp/utility/master_lib.dart';


import './../model/address_info.dart';

class UserAccountHandlerRepository{
  bool readLocalFile = true ;

  Future<List<Address>> getAddressInfoList() async {
    if (readLocalFile) {
      List<dynamic> resp = jsonDecode(await readJsonAsStringFromAssets(
          "assets/dummy_data/hs_dummy_data_address_list.json"));
      return Address.getListFromJson(resp);
    }

    return Future.value(<Address>[]);
  }

}