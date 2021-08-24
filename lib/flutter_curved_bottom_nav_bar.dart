library flutter_curved_bottom_nav_bar;

import 'package:flutter/material.dart';
import 'package:flutter_curved_bottom_nav_bar/fab_bar/fab_bottom_app_bar.dart';
import 'package:flutter_curved_bottom_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';

import 'fab_bar/fab_bottom_app_bar_item.dart';
import 'curved_bar/curved_action_bar.dart';

class CurvedNavBar extends StatefulWidget {
  /// list of [FABBottomAppBarItem] items
  /// length should be always even eg.- 2,4,6,8
  /// length of [appBarItems] should be equal to the length of [bodyItems]
  final List<FABBottomAppBarItem>? appBarItems;

  /// list of `body` widgets
  /// length should be equal to [appBarItems]
  /// length of [bodyItems] should be equal to the length of [appBarItems]
  final List<Widget>? bodyItems;

  ///  then the [body] extends to the bottom of the Scaffold,
  ///   In this case specifying `extendBody: true` ensures that that scaffold's
  ///   body will be visible through the bottom navigation bar's notch.
  ///   [extendBody] default value always true
  final bool extendBody;

  /// A [CurvedActionBar] button displayed floating above [body], in the bottom center.
  /// Typically a [FloatingActionButton].
  final CurvedActionBar? actionButton;

  /// [Color] of selected tab
  /// [activeColor] default value always [Colors.black]
  final Color? activeColor;

  /// [Color] of unselected tab
  /// [inActiveColor] default value always [Colors.black26]
  final Color? inActiveColor;

  /// background [Color] of navigation bar
  /// [navBarBackgroundColor] default value always [Colors.white]
  final Color? navBarBackgroundColor;

  /// Scaffold [body]
  /// when [actionButton] selected
  final Widget? actionBarView;

  CurvedNavBar(
      {@required this.appBarItems,
        @required this.bodyItems,
        this.extendBody = true,
        this.actionButton,
        this.activeColor = Colors.black,
        this.inActiveColor = Colors.black26,
        this.navBarBackgroundColor = Colors.white,
        this.actionBarView}) {
    assert(this.appBarItems != null);
    assert(this.bodyItems != null);
    assert(this.appBarItems!.length == this.bodyItems!.length);
  }

  @override
  _CurvedNavBarState createState() => _CurvedNavBarState();
}

class _CurvedNavBarState extends State<CurvedNavBar> {
  /// index of selected nav bar
  int selectedIndex = 0;

  /// true when [actionButton] is selected
  bool isCentreSelected = false;

  @override
  Widget build(BuildContext context) {
    return widget.actionButton != null
        ? Scaffold(
      extendBody: widget.extendBody,
      floatingActionButton: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              isCentreSelected = true;
              widget.actionButton!.onTab!(true);
            });
          },
          child: isCentreSelected
              ? widget.actionButton!.activeIcon!
              : widget.actionButton!.inActiveIcon != null
              ? widget.actionButton!.inActiveIcon
              : widget.actionButton!.activeIcon),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: widget.actionButton!.text ?? "",
        inActiveColor: widget.inActiveColor,
        activeColor: widget.activeColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) {
          /// execute when navigation bar is selected
          setState(() {
            /// set current tab index
            selectedIndex = index;

            /// to get know [actionButton] is selected or not
            isCentreSelected = false;
          });
        },
        centerSelected: isCentreSelected,
        backgroundColor: widget.navBarBackgroundColor,
        items: widget.appBarItems != null ? widget.appBarItems : [],
      ),
      body: Center(
        child: isCentreSelected
            ? widget.actionBarView != null
            ? widget.actionBarView
            : widget.bodyItems![selectedIndex]
            : widget.bodyItems![selectedIndex],
      ),
    )
        : Scaffold(
      extendBody: widget.extendBody,
      bottomNavigationBar: FABBottomAppBar(
        inActiveColor: widget.inActiveColor,
        activeColor: widget.activeColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) {
          /// execute when navigation bar is selected
          setState(() {
            /// set current tab index
            selectedIndex = index;

            /// to get know [actionButton] is selected or not
            isCentreSelected = false;
          });
        },
        centerSelected: isCentreSelected,
        backgroundColor: widget.navBarBackgroundColor,
        items: widget.appBarItems != null ? widget.appBarItems : [],
      ),
      body: Center(
        child: widget.bodyItems![selectedIndex],
      ),
    );
  }
}

