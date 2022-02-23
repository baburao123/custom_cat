import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


import './ui/tab_layout.dart';

import './ui/product/product_listing_screen_v2.dart';

//Provider
import './providers/product_handler_provider.dart';
import './providers/user_cart_handler_provider.dart';
import './providers/auth_provider.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(80, 56, 189, 1)));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductHandlerProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserCartHandlerProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
      ],
      child: LayoutBuilder(
        //return LayoutBuilder
        builder: (context, constraints) {
          return OrientationBuilder(

            builder: (context, orientation) {

              SizerUtil.setScreenSize( constraints, orientation); //initialize SizerUtil
              return MaterialApp(
                title: 'eVCards',
                theme: ThemeData(
                  fontFamily: 'Roboto',
                  accentColor: Color.fromRGBO(243, 81, 108, 1),
                  backgroundColor: Colors.white,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  buttonTheme: ButtonThemeData(
                    buttonColor: Color.fromRGBO(243, 81, 108, 1),
                    textTheme: ButtonTextTheme.accent,
                  ),

                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      textStyle: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> states) {
                          final headline3 =
                              Theme.of(context).textTheme.headline6;
                          if (states.contains(MaterialState.pressed) ||
                              states.contains(MaterialState.hovered)) {
                            final textStyle = headline3.copyWith(
                                foreground: Paint()
                                  ..color = Colors.deepOrange);
                            return textStyle;
                          }
                          if (states.contains(MaterialState.disabled)) {
                            final textStyle = headline3.copyWith(
                                foreground: Paint()..color = Colors.grey);
                            return textStyle;
                          } else {
                            final textStyle = headline3.copyWith(
                                foreground: Paint()
                                  ..color =
                                  Color.fromRGBO(243, 81, 108, 1));
                            return textStyle;
                          }
                          //return headline3;
                        },
                      ),
                    ),
                  ),
                ),

                //home:TabView(),
                home:ProductListingScreen(),
                debugShowCheckedModeBanner: false,

              );
            },
          );
        },
      ),
    );
  }



}
