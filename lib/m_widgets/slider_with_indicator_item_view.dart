import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';

class SliderWithIndicatorItemView extends StatefulWidget {
  final List<String> banners;

  const SliderWithIndicatorItemView({Key key, this.banners}) : super(key: key);

  @override
  _SliderWithIndicatorItemViewState createState() =>
      _SliderWithIndicatorItemViewState();
}

class _SliderWithIndicatorItemViewState
    extends State<SliderWithIndicatorItemView> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: widget.banners.length ?? 0,
          itemBuilder: (BuildContext context, int itemIndex, realIdx) =>
              /*CachedNetworkImage(
            imageUrl: widget.banners.elementAt(itemIndex),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          )*/
          Image.asset(widget.banners.elementAt(itemIndex) ,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,),
          options: CarouselOptions(
            //autoPlay: true,
            height: 100.w,
            autoPlayInterval: Duration(seconds: 5),
            initialPage: 0,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Align(
           alignment: Alignment.bottomLeft,
          child: Container(
          //  margin: EdgeInsets.only(left: 2.0.w),
    padding: EdgeInsets.all(1.0.w),
            /*decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                *//*border: Border.all(
    color: Colors.red[500],
    ),*//*
                borderRadius: BorderRadius.all(Radius.circular(12))),*/
            color: Color.fromRGBO(255, 255, 255, 0.5),
            child: Row(
             // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.banners.map((url) {
                  int index = widget.banners.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Theme.of(context).accentColor
                          : Color.fromRGBO(
                              0, 0, 0, 0.9), //Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList()),
          ),
        ),
      ],
    );
  }
}
