import 'package:flutter/material.dart';

import 'fab_bottom_app_bar_item.dart';

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.inActiveColor,
    this.activeColor,
    this.notchedShape,
    this.onTabSelected,
    this.centerSelected = false,
  }) {
    assert(this.items!.length % 2 == 0);
  }

  /// [List] of [FABBottomAppBarItem]
  /// length should be even eg.- 2,4,6
  final List<FABBottomAppBarItem>? items;

  /// [Text] label for [actionButton]
  final String? centerItemText;

  /// height of navigation bar
  final double? height;

  /// [FABBottomAppBarItem] icon size
  final double? iconSize;

  /// background [Color] of navigation bar
  final Color? backgroundColor;

  /// unselected navigation bar [Color]
  final Color? inActiveColor;

  /// selected navigation bar [Color]
  final Color? activeColor;

  /// [NotchedShape] of navigation var
  final NotchedShape? notchedShape;

  /// call back [Function]
  /// return [int] value when navigation tab item selected
  final ValueChanged<int>? onTabSelected;

  /// [bool] value is true if [actionButton] is selected
  /// else false
  final bool centerSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  /// method execute when tab item selected
  _updateIndex(int index) {
    widget.onTabSelected!(index);
    setState(() {
      /// set current tab index
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items!.length, (int index) {
      return _buildTabItem(
        item: widget.items![index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(
                  color: widget.centerSelected
                      ? widget.activeColor
                      : widget.inActiveColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem? item,
    int? index,
    ValueChanged<int>? onPressed,
  }) {
    Color color = _selectedIndex != index && !widget.centerSelected
        ? widget.inActiveColor!
        : !widget.centerSelected
            ? widget.activeColor!
            : widget.inActiveColor!;
    Widget? icon = _selectedIndex != index && !widget.centerSelected
        ? item!.inActiveIcon
        : !widget.centerSelected
            ? item!.activeIcon
            : item!.inActiveIcon;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed!(index!),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                icon!,
                Text(
                  item.text!,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
