import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MenuItem.dart';
import 'constants.dart';
import 'doorDrawerProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DoorDrawer()),
      ],
      child: MaterialApp(
        home: MyDoorDrawer(),
      ),
    );
  }
}

class MyDoorDrawer extends StatefulWidget {
  @override
  _MyDoorDrawerState createState() => _MyDoorDrawerState();
}

class _MyDoorDrawerState extends State<MyDoorDrawer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var doorProvider = Provider.of<DoorDrawer>(context, listen: false);
    Size _size = MediaQuery.of(context).size;
    var width = _size.width;
    var height = _size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Consumer<DoorDrawer>(builder: (context, doorDrawer, child) {
                return Container(
                  padding: EdgeInsets.all(16),
                  height: height,
                  width: width,
                  color: Colors.white,
                  child: doorDrawer.getWidget(),
                );
              }),
              AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY((90 * animation.value) * (3.14 / 180)),
                    origin: Offset(width / 2, 0),
                    alignment: FractionalOffset.center,
                    child: Container(
                      height: height,
                      width: width,
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Menu',
                            style: drawer_text_Heading,
                          ),
                          MenuItem(
                            doorProvider: doorProvider,
                            controller: _controller,
                            itemName: 'Home',
                            itemNumber: 1,
                          ),
                          MenuItem(
                            doorProvider: doorProvider,
                            controller: _controller,
                            itemName: 'Item 1',
                            itemNumber: 2,
                          ),
                          MenuItem(
                            doorProvider: doorProvider,
                            controller: _controller,
                            itemName: 'Item 2',
                            itemNumber: 3,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              InkWell(
                onTap: () {
                  if (doorProvider.getDrawerValue() == true) {
                    _controller.reverse();
                    doorProvider.setDrawerValue(false);
                  } else {
                    _controller.forward();
                    doorProvider.setDrawerValue(true);
                  }
                },
                child: Consumer<DoorDrawer>(
                  builder: (context, doorDrawer, child) {
                    return Padding(
                      padding: EdgeInsets.all(30),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.arrow_menu,
                        progress: _controller,
                        color: doorDrawer.getDrawerValue() == true
                            ? Colors.black
                            : Colors.white,
                        semanticLabel: 'Show Or Hide menu',
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
