import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

import './../model/product_info.dart';
import 'slider_with_indicator_item_view.dart';

class ProductDetailWidget extends StatefulWidget {
  final Product mProduct ;
  final Function onClickActionCallBack;

  const ProductDetailWidget({Key key, this.mProduct, this.onClickActionCallBack}) : super(key: key);

  @override
  _ProductDetailWidgetState createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  @override
  Widget build(BuildContext context) {
    /*return Container(
      child: Column(
        children: [
          Icon(Icons.one_k_plus),
          Text(widget.mProduct.proTitle),
          Text(widget.mProduct.proSubTitle),
          Text(widget.mProduct.proPrice.toString()),
          Text(widget.mProduct.proDesc),
        ],
      ),
    );*/
    return _getPageView();
  }


  Widget _getView() {
    return Container(
      alignment: Alignment.center,
      height: 100.0.w,
      decoration: BoxDecoration(
          border: Border(
              /*bottom: BorderSide(
                  width: 4, color: Color.fromRGBO(243, 81, 108, 1))*/
          )),
      child:

      SliderWithIndicatorItemView(banners: [widget.mProduct.image])
      /*CarouselSlider.builder(
              itemCount: widget.mProduct.banners.length ?? 1,
              itemBuilder: (BuildContext context, int itemIndex, realIdx) =>
                  //Image.asset("assets/dummy_res/sample_01.jpg" ,),
                  Image.asset(widget.mProduct.banners[itemIndex] ,),
              options: CarouselOptions(
                  //autoPlay: true,
                  height: 100.0.w,
                  autoPlayInterval: Duration(seconds: 2),
                  initialPage: 2,
                  viewportFraction: 1),
            )*/
          ,
    );
  }

  Widget _getPageDetails(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 2.0.w,right: 2.0.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.0.h,),
           Row(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [


               Expanded(
                 flex: 7,
                 child:Text(widget.mProduct.name,
                     style: TextStyle(
                         color: Colors.black,
                         fontSize: 14.0.sp,
                         fontWeight: FontWeight.bold
                       //backgroundColor: Theme.of(context).accentColor
                     ),
                   maxLines: 3,
                   overflow: TextOverflow.ellipsis,
                   textAlign: TextAlign.start,
                 ),
               ),
               Expanded(
                 flex: 3,
                 child:Container(
                   alignment: Alignment.centerRight,
                   child: Text("₹ ${widget.mProduct.proPrice}",
                       style: TextStyle(
                           color: Theme.of(context).accentColor,
                           fontSize: 14.0.sp,
                           fontWeight: FontWeight.bold
                         //backgroundColor: Theme.of(context).accentColor
                       )),
                 ),
               ),

             ],
           ),
            SizedBox(height: 2.0.h,),
            Text(widget.mProduct.description,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0.sp,
                  //backgroundColor: Theme.of(context).accentColor
                ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 1.0.h,),
            SizedBox(
              height: 1,
              child: Container(color: Colors.grey,),
            ),
            SizedBox(height: 3.0.h,),
        Html(
            data: widget.mProduct.description,
            //style: TextStyle(fontSize: 15),
      ),SizedBox(height: 4.0.h,),

            /*Text(widget.mProduct.proDesc,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10.0.sp,
                  //backgroundColor: Theme.of(context).accentColor
                )),*/

          ],
        ),
      ),
    );
  }


  Widget _getPageView(){
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight:    100.0.w,
            floating: false,
            pinned: false,

            //snap: false,
           /* bottom: PreferredSize(
              child:  Text(widget.mProduct.proTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0.sp,
                    //backgroundColor: Theme.of(context).accentColor
                  )),
              preferredSize: Size.fromHeight(4.0.h),
            ),*/
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                /*title: Text(widget.mProduct.proTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0.sp,
                      //backgroundColor: Theme.of(context).accentColor
                    )),*/
                background:
                _getView(),



              /*Image.network(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                )*/
            ),
          ),
        ];
      },
      body: _getPageDetails()/*Center(
        //child: Text("Sample Text"),
        child: Container(
          height: double.maxFinite,
          color: Colors.grey,
            child: _getPageDetails()
        ),
      )*/,
    );
  }

}
