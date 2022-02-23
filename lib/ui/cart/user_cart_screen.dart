import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import './../user_account/manage_address_landing_screen.dart';

import './../../providers/product_handler_provider.dart';
import './../../providers/user_cart_handler_provider.dart';

import './../../model/product_info.dart';

import './../../m_widgets/cart_product_item_view_widget.dart';
import './../product/product_detail_page.dart';

class UserCardScreen extends StatefulWidget {
  @override
  _UserCardScreenState createState() => _UserCardScreenState();
}

class _UserCardScreenState extends State<UserCardScreen> {
  List<Product> mProductList = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /*appBar: AppBar(
        title: Text( 's Cart'),
      ),*/
      body: Consumer<UserCartHandlerProvider>(
        builder: (BuildContext context, UserCartHandlerProvider cart, Widget child) {
          print("--->${cart.products.length}");
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: cart.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (cart.products.isEmpty) {
                      return Text('no products in cart');
                    }
                    final item = cart.products[index];
                    return Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          Container(

                            child: Icon(Icons.check),),
                          Column(children: [ Text(item.product.name ?? ''), Text('cost: ${item.qty ?? '1'} X ${item.product.proPrice.toString() ?? 'free'}'),],),],),

                       // subtitle:
                       // trailing: Text('tap to remove from cart'),
                        trailing: IconButton(icon: Icon(Icons.delete_forever), onPressed: (){
                          context.read<UserCartHandlerProvider>().removeFromCart(item.product);
                        },),
                        /*onTap: () {
                          context.read<UserCartHandlerProvider>().removeFromCart(item.product);
                        },*/
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Align(
                alignment: Alignment.center,
                child:
                _getTotalPriceWidget(context.select((UserCartHandlerProvider c) => c.total.toStringAsFixed(2)))
                /*Text(
                  'TOTAL: ${context.select((UserCartHandlerProvider c) => c.total.toStringAsFixed(2))}',
                  style: Theme.of(context).textTheme.headline4,
                )*/,
              ),
            ],
          );
        },
      ),
    );
  }


  Widget _getTotalPriceWidget(String totalPriceStr){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'TOTAL: ${totalPriceStr}',
          style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).primaryColor),

        ),
        ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.grey,) ,
          child: Text("Buy",),
          onPressed: (){
            _manageAddress();
          },
        )
      ],
    );
  }

  void _manageAddress() {
    pushNewScreen(
      context,
      screen: ManageAddressLandingScreen(purposeOfAction: "address_picker",),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.fade, // OPTIONAL
    ).then((value){

    }).catchError((err){
      print(err);
    });
  }


  @override
  Widget buildv1(BuildContext context) {
    /*return Scaffold(
      appBar: AppBar(title: Text("Product Listing"),),
      body:   _getProductDetailsWidget(),
    );
    */
    return _getProductDetailsWidget() ;
  }

  Widget _getProductDetailsWidget(){
    return FutureBuilder<List<Product>>(
      future: _fetchProductList(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if(!snapshot.hasError || snapshot.hasData){

          if(snapshot.data!= null && snapshot.data.isNotEmpty){
            mProductList.clear();
            mProductList .addAll( snapshot.data);
            // print(mSaleList.length);

            return  ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // itemCount: mSaleList.length+1,
                itemCount: mProductList.length,
                itemBuilder: (ctx, index){

                  return CartProductItemViewWidget(mProduct: mProductList[index],mOnClickCallbackAction: (
                      {String action}){
                    _startActionSample();
                  });
                  //return Container();
                }
            );
          }
          return   Container(
            height: 40,
            width: 30,
            color: Colors.red,
            child: Text("Error"),
          );
        }else{
          return   Container(
            height: 40,
            width: 30,
            color: Colors.red,
            child: Text("Error"),
          );
        }

      },
    );
  }

  Future<List<Product>> _fetchProductList() async{
    var tt = await context.read<ProductHandlerProvider>().fetchAllProductList();
    if(tt != null && tt.isNotEmpty)
      return tt ;
    return <Product>[] ;
  }

  _startActionSample(){
    pushNewScreen(
      context,
      screen: ProductDetailsPage(),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.fade, // OPTIONAL
    ).then((value){

    }).catchError((err){
      print(err);
    });
  }
}






