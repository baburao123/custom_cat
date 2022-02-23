
import 'package:flutter/foundation.dart';

import './../model/address_info.dart';
import './../repository/user_account_handler_repository.dart';

class AuthProvider with ChangeNotifier{
  Future<List<Address>> fetchAllAddressInfo() async {
    try {
      UserAccountHandlerRepository repo = UserAccountHandlerRepository();
      final resp = await repo.getAddressInfoList();
      resp.forEach((element) {
        print("${element.addressId}: ${element.addressInfo}" );
      });
      return resp;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}