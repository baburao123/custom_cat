import 'package:flutter/material.dart';
import 'package:CatelogApp/ui/cart/check_out_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import './../../model/address_info.dart';
import './../../providers/auth_provider.dart';
import './../../m_widgets/manage_address_list_item_widget.dart';

import './../../utility/master_lib.dart' show showToast;


class ManageAddressLandingScreen extends StatefulWidget {
  final String purposeOfAction;

  const ManageAddressLandingScreen({Key key, this.purposeOfAction}) : super(key: key);


  @override
  _ManageAddressLandingScreenState createState() => _ManageAddressLandingScreenState();
}

class _ManageAddressLandingScreenState extends State<ManageAddressLandingScreen> {
  List<Address> mAddressList = [];
  Address selectedAddress ;

  bool isAddressPicker = false ;

  @override
  Widget build(BuildContext context) {

    isAddressPicker = widget.purposeOfAction != null && widget.purposeOfAction == "address_picker" ;
    return Scaffold(
      appBar: AppBar(title: Text( isAddressPicker ? "Select Address": "Manage Address"),   actions: [
        IconButton(icon: Icon(Icons.add), onPressed: (){
          //Action add new address
          showToast("Coming soon!!");
        }),
      ],),
      body: _getAddressList(),
    );
  }

Widget _getAddressList(){
    return FutureBuilder<List<Address>>(
      future: getAddressList(),
      builder:(context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if(!snapshot.hasError || snapshot.hasData){

          if(snapshot.data!= null && snapshot.data.isNotEmpty){
            mAddressList.clear();
            mAddressList .addAll( snapshot.data);

            if(selectedAddress == null && isAddressPicker){
              selectedAddress = mAddressList[0];
            }
            return  Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      // itemCount: mSaleList.length+1,
                      itemCount: mAddressList.length/*+1*/,
                      itemBuilder: (ctx, index){

                       /* if(index == mAddressList.length){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(onPressed: (){

                            },  child: Text("Continue"),),
                          );
                        }*/

                        return ManageAddressListItemWidget(addressInfo:mAddressList[index],
                            isSelected:( selectedAddress!= null && selectedAddress.addressId == mAddressList[index].addressId),
                            onActionClicked:(
                            {String action, Address selectedAddress}){

                          if(isAddressPicker &&  action == "address_selected"){
                            setState(() {
                              this.selectedAddress = selectedAddress;
                            });
                          }
                        }
                        ) ;
                        //return Container();
                      }
                  ),
                ),


                if(isAddressPicker)
                Divider(),

                if(isAddressPicker)
                Align(
                  alignment: Alignment.bottomRight,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                      _startCheckOutSummery();
                    },  child: Text("Continue"),),
                  )
                  /*Text(
                  'TOTAL: ${context.select((UserCartHandlerProvider c) => c.total.toStringAsFixed(2))}',
                  style: Theme.of(context).textTheme.headline4,
                )*/,
                ),
              ],
            );
          }


          return   Center(
            child: Container(
              height: 40,
              width: 30,
              color: Colors.red,
              child: Text("Error"),
            ),
          );
        }else{
          return   Center(
            child: Container(
              height: 40,
              width: 30,
              color: Colors.red,
              child: Text("Error"),
            ),
          );
        }

      },

    );
  }


  Future<List<Address>> getAddressList() async {

    var tt = await context.read<AuthProvider>().fetchAllAddressInfo();
    if(tt != null && tt.isNotEmpty)
    return tt ;
    return <Address>[] ;
    /* List<String> addressList = [];
    addressList.add("No 5 , 5th cross , 5th main, Bangalore 560043");
    addressList.add("No 2 , 3th cross , 10th main, Bangalore 560001");
    addressList.add("No 1 , 1th cross , 9th B main, Bangalore 560056");

    return Future.value(addressList) ;*/
  }


  void addNewAddress(){

  }



  void _startCheckOutSummery(){
    pushNewScreen(
      context,
      screen: CheckOutScreen(selectedAddress: this.selectedAddress,),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.fade, // OPTIONAL
    ).then((value){

    }).catchError((err){
      print(err);
    });
  }

}
