import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import './../cart/user_cart_landing_screen.dart';

import './../product/product_listing_screen.dart';
import './../product/search_landing_screen.dart';
import './../../m_widgets/category_item_view_widget.dart';

import './../../providers/product_handler_provider.dart';
import './../../providers/user_cart_handler_provider.dart';
import './../../model/category_info.dart';

import './../../utility/master_lib.dart' show showToast;

class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  List<Category> mCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              icon: Icon(Icons.search_rounded), onPressed: _startSearchAction),
         /* IconButton(
              icon: Icon(Icons.shopping_cart), onPressed: _startCartAction),*/
          _getCartValueWidget(),
        ],
      ),
      body: _getCategoryDetailsWidget(),
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

  Widget _getCategoryDetailsWidget() {
    return FutureBuilder<List<Category>>(
      future: _fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasError || snapshot.hasData) {
          if (snapshot.data != null && snapshot.data.isNotEmpty) {
            mCategories.clear();
            mCategories.addAll(snapshot.data);
            // print(mSaleList.length);

            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // itemCount: mSaleList.length+1,
                itemCount: mCategories.length,
                itemBuilder: (ctx, index) {
                  return CategoryItemViewWidget(
                      mCategory: mCategories[index],
                      mOnClickCallbackAction: (
                          {String action, Category selectedCategory}) {
                        _startActionSample(selectedCategory);
                      });
                  //return Container();
                });
          }

          return Container(
            height: 40,
            width: 30,
            color: Colors.red,
            child: Text("Error"),
          );
        } else {
          return Container(
            height: 40,
            width: 30,
            color: Colors.red,
            child: Text("Error"),
          );
        }
      },
    );
  }

  Future<List<Category>> _fetchCategories() async {
    var tt = await context.read<ProductHandlerProvider>().fetchAllCategories();
    if (tt != null && tt.isNotEmpty) return tt;
    return <Category>[];
  }

  _startActionSample(Category selectedCategory) {
    pushNewScreen(
      context,
      screen: ProductListingScreen(selectedCategory: selectedCategory),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.fade, // OPTIONAL
    ).then((value) {}).catchError((err) {
      print(err);
    });
  }

  _startSearchAction() {
    pushNewScreen(
      context,
      screen: SearchLandingScreen(),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.fade, // OPTIONAL
    ).then((value) {}).catchError((err) {
      print(err);
    });
  }

  _startCartAction() {
    if (context.read<UserCartHandlerProvider>().isCartNotEmpty) {
      pushNewScreen(
        context,
        screen: UserCartLandingScreen(),
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.fade, // OPTIONAL
      ).then((value) {}).catchError((err) {
        print(err);
      });
    } else {
      showToast("Cart is empty");
    }
  }
}
