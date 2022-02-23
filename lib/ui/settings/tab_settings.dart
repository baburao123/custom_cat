import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TabSettings extends StatefulWidget {
  @override
  _TabSettingsState createState() => _TabSettingsState();
}

class _TabSettingsState extends State<TabSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"),),
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
                      onTap: (){_launchURLContactSupport();},
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

                          _getSettingView('Contact Support', "assets/setting_icon/ic_blue_support.png")

                      ),
                    ),
                    InkWell(
                      onTap: (){_launchURLPrivacyPolicy();},
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
                          _getSettingView('Privacy Policy', "assets/setting_icon/ic_blue_lock.png")

                      ),
                    ),



                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(1.0.w, 0.0.h, 1.0.w, 0.0.h),
                      padding: EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 1.9.h),

                      child:
                      _getSettingWithSubView("App Version","assets/setting_icon/ic_blue_setting.png",getVersion) ,

                    )
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
        child: Icon(Icons.settings),
      ),
      title: Container(child: Text(title ,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12.0.sp,
        ),) , width: 80.0.w, ),
      trailing:  Icon(Icons.chevron_right , ),
    );
  }
  Future<String> getVersion() async {
   // PackageInfo packageInfo = await PackageInfo.fromPlatform();
   // return "V-${packageInfo.version}"  ;
    return Future.value("1.0.0");
  }
  Future<String> _getUserEmail() async {
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(UtilsRepository.currentUserEmail);*/
    return Future.value("guest@guest.com");
  }

  void _launchURLContactSupport() {}

  void _launchURLPrivacyPolicy() {}

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