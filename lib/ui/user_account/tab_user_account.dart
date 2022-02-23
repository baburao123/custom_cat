import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';


import './../user_account/manage_address_landing_screen.dart';
import './../cart/user_order_landing_screen.dart';

class TabUserAccount extends StatefulWidget {
  @override
  _TabUserAccountState createState() => _TabUserAccountState();
}

class _TabUserAccountState extends State<TabUserAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Account"),),
      body: Container(
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 4,
              child: Container(
                margin: EdgeInsets.fromLTRB(1.0.w, 0.0.h, 1.0.w, 1.0.h),
                child: Column(
                  children: [

                    InkWell(
                      onTap: _manageOrders,
                      child: Container(

                          margin: EdgeInsets.fromLTRB(1.0.w, 0.0.h, 1.0.w, 0.0.h),
                          padding: EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 1.9.h),

                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Colors.grey
                                  )
                              )
                          ),
                          child:

                          _getSettingView('Your Orders', "assets/setting_icon/ic_blue_support.png")

                      ),
                    ),
                    InkWell(
                      onTap: (){_manageAddress();},
                      child: Container(

                          margin: EdgeInsets.fromLTRB(1.0.w, 0.0.h, 1.0.w, 0.0.h),
                          padding: EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 1.9.h),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Colors.grey
                                  )
                              )
                          ),
                          child:
                          _getSettingView('Manage Address', "assets/setting_icon/ic_blue_lock.png")

                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(1.0.w, 0.0.h, 1.0.w, 0.0.h),
                      padding: EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 1.9.h),
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Colors.grey
                            ),

                          )
                      ),
                      child:
                      _getSettingWithSubView("Email","assets/setting_icon/ic_d_blue_email.png",_getUserEmail) ,
                    ),
                    InkWell(
                      onTap: () {

                      },
                      child: Container(
                          margin: EdgeInsets.fromLTRB(1.0.w, 0.0.h, 1.0.w, 0.0.h),
                          padding: EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 1.9.h),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: Colors.grey
                                  )
                              )
                          ),
                          child:
                          _getSettingView('Reset Password', "assets/setting_icon/ic_blue_reset.png")

                      ),
                    ),
                    InkWell(
                      onTap: (){

                        showDialog(context: context,
                            builder: (context) => new AlertDialog(
                              title: Text('Are you sure?'),
                              content: Text('Do you want to logout?'),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: (){Navigator.of(context).pop();},
                                    child: Text('No')),
                                FlatButton(
                                    onPressed: () {
                                      // Provider.of<Auth>(context, listen: false) .logout();
                                      Navigator.of(context).pop();


                                    },
                                    child: Text('Yes'))
                              ],
                            )
                        );

                      },
                      child: Container(

                          margin: EdgeInsets.fromLTRB(1.0.w, 0.0.h, 1.0.w, 0.0.h),
                          padding: EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 1.9.h),
                          decoration: BoxDecoration(

                          ),
                          child:
                          _getSettingView('Logout', "assets/setting_icon/ic_blue_logout.png")

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSettingView(String title, String iconName , ){
    return ListTile(
      leading: SizedBox(
        width: 5.0.w,
        height: 5.0.w,
        //child: Image.asset( iconName,),
        child: Icon(Icons.account_circle),
      ),
      title: Container(child: Text(title ,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12.0.sp,
        ),) , width: 80.0.w, ),
      trailing:  Icon(Icons.chevron_right , ),
    );
  }
  Future<String> _getUserEmail() async {



    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(UtilsRepository.currentUserEmail);*/
    return Future.value("guest@guest.com");
  }

  void _launchURLContactSupport() {}

  void _launchURLPrivacyPolicy() {}




  void _manageOrders() {
    pushNewScreen(
      context,
      screen: UserOrderLandingScreen(/*purposeOfAction: "address_viewer",*/),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.fade, // OPTIONAL
    ).then((value){

    }).catchError((err){
      print(err);
    });
  }

  void _manageAddress() {
    pushNewScreen(
        context,
        screen: ManageAddressLandingScreen(purposeOfAction: "address_viewer",),
    withNavBar: false, // OPTIONAL VALUE. True by default.
    pageTransitionAnimation: PageTransitionAnimation.fade, // OPTIONAL
    ).then((value){

    }).catchError((err){
    print(err);
    });
  }

  Widget _getSettingWithSubView(String title, String iconName , Function _futureFunction){
    return ListTile(
      leading: SizedBox(
        width: 5.0.w,
        height: 5.0.w,
        //child: Image.asset( iconName,),
        child: Icon(Icons.settings),
      ),
      title: Container(child: Text(title ,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12.0.sp,
        ),) , width: 80.0.w, ),
      subtitle:  FutureBuilder(
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else if(snapshot.hasData && snapshot.data != null) {
            return Text("${snapshot.data}", style: TextStyle(
                fontSize: 10.0.sp),);;
          } else return Text("-", style: TextStyle(
              fontSize: 10.0.sp),);
        },
        future: _futureFunction(),
      ),
      trailing:  Icon(Icons.chevron_right , ),
    );
  }




}