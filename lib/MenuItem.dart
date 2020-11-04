import 'package:flutter/material.dart';

import 'constants.dart';
import 'doorDrawerProvider.dart';
class MenuItem extends StatelessWidget {
  const MenuItem({
    Key key,
    @required this.itemNumber,
    @required this.itemName,
    @required this.doorProvider,
    @required this.controller,
  }) : super(key: key);

  final DoorDrawer doorProvider;
  final AnimationController controller;
  final String itemName;
  final int itemNumber;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        itemName,
        style: drawer_text,
      ),
      onPressed: () {
        doorProvider.setWidget(itemNumber);
        controller.forward();
      },
    );
  }
}