import 'package:flutter/material.dart';

import './../model/address_info.dart';

class ManageAddressListItemWidget extends StatelessWidget {
  final Address addressInfo;
  final Function onActionClicked;
  final bool isSelected ;

  const ManageAddressListItemWidget(
      {Key key, this.addressInfo, this.onActionClicked , this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onActionClicked(action:"address_selected",selectedAddress:addressInfo);

      },
      child: Card(
        color: isSelected? Colors.blue.shade100: null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${addressInfo.addressLabel} Address",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text("\n${addressInfo.addressInfo}"),
              Text(addressInfo.pincode),
              Text(
                "Ph: ${addressInfo.phone}",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      onActionClicked("delete");
                    },
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      onActionClicked("edit");
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
