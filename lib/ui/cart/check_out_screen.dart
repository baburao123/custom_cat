import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import './../../model/address_info.dart';
import './../../providers/user_cart_handler_provider.dart';

import './../../utility/master_lib.dart' show showToast;

class CheckOutScreen extends StatefulWidget {
  final Address selectedAddress;

  const CheckOutScreen({Key key, this.selectedAddress}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Summary"),
        ),
        body: _getSummeryWidget());
  }

  Widget _getSummeryWidget() {
    return Column(
      children: [
        _getAddress(),
        _getTotal(),
        ElevatedButton(
          onPressed: () {},
          child: Text("Place Order"),
        ),
      ],
    );
  }

  Widget _getTotal() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Final Total payable",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              "${context.read<UserCartHandlerProvider>().total}",
              style: TextStyle(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAddress() {
    return Card(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery Address",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            Text(
              "${widget.selectedAddress.addressLabel}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
                "${widget.selectedAddress.addressInfo} ${widget.selectedAddress.pincode}"),
            Text(
              "Ph: ${widget.selectedAddress.phone}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
