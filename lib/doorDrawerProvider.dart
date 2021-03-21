
import 'package:flutter/cupertino.dart';
import 'package:gate_open_drawer/Home.dart';

import 'Item1.dart';
import 'Item2.dart';

class DoorDrawer extends ChangeNotifier {
  Widget selectedWidget = Home();
  bool drawerCloseBool = true;
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
    setDrawerClose(true);
    notifyListeners();
  }

  bool drawerClose(){
    return drawerCloseBool;
  }
  void setDrawerClose(bool value){
    drawerCloseBool = value;
    notifyListeners();
  }
}