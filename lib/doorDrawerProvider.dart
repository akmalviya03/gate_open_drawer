
import 'package:flutter/cupertino.dart';
import 'package:gate_open_drawer/Home.dart';

import 'Item1.dart';
import 'Item2.dart';

class DoorDrawer extends ChangeNotifier {
  Widget selectedWidget = Home();
  bool showDrawerMenu = true;
  Widget getWidget(){
    return selectedWidget;
  }

  void setWidget(int itemNumber){
    switch(itemNumber) {
      case 1: {
        selectedWidget = Home();
      }
      break;

      case 2: {
        selectedWidget = Item1();
      }
      break;

      default: {
        selectedWidget = Item2();
      }
      break;
    }
    setDrawerValue(true);
    notifyListeners();
  }

  bool getDrawerValue(){
    return showDrawerMenu;
  }
  void setDrawerValue(bool value){
    showDrawerMenu = value;
    notifyListeners();
  }
}