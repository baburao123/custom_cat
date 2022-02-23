import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


//UI
import './home/tab_home.dart';
import './user_account/tab_user_account.dart';
import './settings/tab_settings.dart';

//Utility
import './../utility/master_ui_constant.dart';

class TabView extends StatefulWidget {
  static const routeName = '/master-home-screen';
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);


  List<Widget> _buildScreens() {
    return [
      TabHome(),
      TabUserAccount(),
      TabSettings()
     //facebookSignIn: widget.facebookSignIn,)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home_filled)/*ImageIcon(AssetImage('assets/WebP_encoded/home.webp'))*/,
          activeColorPrimary: Color.fromRGBO(243, 81, 108, 1),
          inactiveColorPrimary: CupertinoColors.systemGrey,
          iconSize: MasterUiConstant.bottomNavIconSize),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle)/*ImageIcon(AssetImage('assets/WebP_encoded/contacts.webp'))*/,
          activeColorPrimary: Color.fromRGBO(243, 81, 108, 1),
          inactiveColorPrimary: CupertinoColors.systemGrey,
          iconSize: MasterUiConstant.bottomNavIconSize),

      PersistentBottomNavBarItem(
          icon: Icon(Icons.settings)/*ImageIcon(AssetImage('assets/WebP_encoded/ic_bell.webp'))*/,
          activeColorPrimary: Color.fromRGBO(243, 81, 108, 1),
          inactiveColorPrimary: CupertinoColors.systemGrey,
          iconSize: MasterUiConstant.bottomNavIconSize),

    ];
  }


  Future<bool> onWillPop(BuildContext ctx) async {
    print("coming here");
    if (_controller.index != 0) return true;

    return await showAlertDialog(ctx);
  }

  Future<bool> showAlertDialog(BuildContext context) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",),
      onPressed: () {
        Navigator.of(context).pop(false);
        //return false ;
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Exit",
      ),
      onPressed: () {
        Navigator.of(context).pop(true);
        // return  ;
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("Exit"),
      content: Text("Are you sure you want to exit?"),
      contentTextStyle: TextStyle(fontSize: 20 , color: Colors.black),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,

        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears.
        stateManagement: false,
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
        decoration: NavBarDecoration(),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
        NavBarStyle.simple, // Choose the nav bar style with this property.
        onItemSelected: (int position){
          // print("---______---position: $position---->>>>>>");
         // mCurrentVisibleScreen = position ;
        },
      ),
    );
  }
}
