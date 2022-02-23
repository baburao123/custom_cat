import 'package:flutter/material.dart';
import 'package:CatelogApp/utility/master_lib.dart';
import 'package:sizer/sizer.dart';
import 'package:CatelogApp/ui/product/product_detail_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../m_widgets/product_item_view_widget.dart';
import './../cart/user_cart_landing_screen.dart';

//Model
import '../../model/product_info.dart';
import '../../model/category_info.dart';

//Repository
import '../../providers/product_handler_provider.dart';
import '../../providers/user_cart_handler_provider.dart';


class ProductListingScreen extends StatefulWidget {
  final Category selectedCategory ;

  const ProductListingScreen({Key key, @required this.selectedCategory}) : super(key: key);
  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  List<Product> mProductList = [];
  int noOfItemPerRow = 1 ;



  void updateGridView(){
    setState(() {

      if(noOfItemPerRow == 1){

        noOfItemPerRow = 2 ;
      }else{
        noOfItemPerRow = 1 ;


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedCategory.categoryTitle),
        actions: [
          IconButton(icon: Icon(noOfItemPerRow == 1 ?Icons.grid_view :Icons.table_rows ) , onPressed: (){
            updateGridView();
          }, ),
         // IconButton(icon: Icon(Icons.shopping_cart), onPressed: _startCartAction),
          _getCartValueWidget(),
        ],
      ),
      body:   _getProductDetailsWidget(),
    );
  }

  Widget _getCartValueWidget() {
    return InkWell(
      onTap: _startCartAction,
      child: Container(
        margin: EdgeInsets.only(right: 8.0),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              //width: double.minPositive,
              //height: double.minPositive,

              padding: const EdgeInsets.all(4.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child:
                  Consumer<UserCartHandlerProvider>(
                    builder: (context, person, child) {
                      return Text(
                        person.noOfItemsInCart.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      );
                    },
                  )
              ),
            ),
            IconButton(
                icon: Icon(Icons.shopping_cart), onPressed: _startCartAction),
          ],
        ),
      ),
    );
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

            /*WOkring
            return  ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // itemCount: mSaleList.length+1,
                itemCount: mProductList.length,
                itemBuilder: (ctx, index){

                  return ProductItemViewWidget(mProduct: mProductList[index],mOnClickCallbackAction: (
                      {String action}){
                    _startActionSample();
                  });
                  //return Container();
                }
            );*/


            return  GridView.builder(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  //crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3: 2,
                  crossAxisCount: noOfItemPerRow,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                 // childAspectRatio: (2 / 1),
                  childAspectRatio: getViewWidthAndHeight(noOfItemPerRow),
                ),
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                // itemCount: mSaleList.length+1,
                itemCount: mProductList.length,
                itemBuilder: (ctx, index){

                  return ProductItemViewWidget(mProduct: mProductList[index],mOnClickCallbackAction: (
                      {String action}){
                    if(action == "buy"){
                      context.read<UserCartHandlerProvider>().addToCart(mProductList[index]);
                      showToast("Added to cart");
                    }else{
                      _startActionSample();
                    }

                  },
                      noOfItemPerRow: noOfItemPerRow
                  );
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


  double getViewWidthAndHeight(int itemCount){
    if(itemCount == 1){
      return 100.0.w / 25.0.w;
    }else{
      return 1;
    }
  }

  Future<List<Product>> _fetchProductList() async{
    var tt = await context.read<ProductHandlerProvider>().fetchAllProductList();
    tt.addAll(await context.read<ProductHandlerProvider>().fetchAllProductList());
    /*if(tt != null && tt.isNotEmpty)
      return tt ;*/
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
