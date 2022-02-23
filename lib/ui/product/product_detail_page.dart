import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

//Model
import './../../model/product_info.dart';

//Provider
import './../../providers/product_handler_provider.dart';
import './../../providers/user_cart_handler_provider.dart';

import './../../m_widgets/product_detail_widget.dart';
import './../cart/user_cart_landing_screen.dart';

import './../../utility/master_lib.dart' show showToast;

class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Product mProduct ;
  bool isProductAdded = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Product Details"),),
      extendBodyBehindAppBar: true,
      body:
      SafeArea(
        //bottom: false,
        child: _getProductDetailsWidget(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // when clicked on floating action button prompt to create user
          if (isProductAdded) {
            _startCartAction();
          } else {
            context.read<UserCartHandlerProvider>().addToCart(mProduct);
            showToast("Added to cart");
            setState(() {
              isProductAdded = true ;
            });
          }
        },
        label: isProductAdded ?Text('View Cart Info'):  Text('Add To Cart'),
        icon: isProductAdded ?null :Icon(Icons.add) ,
      ),
    );
  }

  Widget _getProductDetailsWidget(){
    return FutureBuilder<Product>(
      future: _fetchProduct(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if(!snapshot.hasError || snapshot.hasData){

          if(snapshot.data!= null ){
            mProduct = snapshot.data;
            // print(mSaleList.length);

            return ProductDetailWidget(
                 mProduct:mProduct,
              onClickActionCallBack: ({String action}){
                showToast(action);
              },
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

  Future<Product> _fetchProduct() async{
      var tt = await context.read<ProductHandlerProvider>().fetchAllProductList();
     /* if(tt != null && tt.isNotEmpty)
        return tt.first;*/
      return null ;
  }

  _startCartAction() {
    pushNewScreen(
      context,
      screen: UserCartLandingScreen(),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.fade, // OPTIONAL
    ).then((value){

    }).catchError((err){
      print(err);
    });
  }

}
