import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/palette.dart';
import 'package:movie_app/feature/watchscreen/watch_screen_provider.dart';
import 'package:provider/provider.dart';
import '../../customwidgets/custom_bottom_bar.dart';

import '../watchscreen/watch_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin<HomeScreen> {
  late TabController bottomTabController;

  @override
  void initState() {
    var prov = Provider.of<WatchScreenProvider>(context, listen: false);
    super.initState();
    bottomTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<WatchScreenProvider>(context, listen: false);

    Widget appBar = Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Color(0xffE5E9EC),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        )
      ]),
      height: 64,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Watch",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    color: Color(0xff202C43))),
          ),
          IconButton(
              padding: EdgeInsets.only(right: 4),
              iconSize: 18,
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Container())),
              icon: Image.asset(
                "assets/icons/Search.png",
                color: Color(0xff202C43),
              )),
        ],
      ),
    );

    return WillPopScope(
        onWillPop: () async {
          if (bottomTabController.previousIndex == 0) {
            bottomTabController.animateTo(0);
            return false;
          }
          return true;
        },
        child: Scaffold(
            bottomNavigationBar:
                CustomBottomBar(controller: bottomTabController),
            backgroundColor: Palette.backgroundColor,
            body: CustomPaint(
              child: TabBarView(
                  controller: bottomTabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: const <Widget>[
                    Center(child: Text("Page 1 Not Found")),
                    WatchScreen(),
                    Center(child: Text("Page 2 Not Found")),
                    Center(child: Text("Page 3 Not Found")),
                  ]),
            )));
  }
}
