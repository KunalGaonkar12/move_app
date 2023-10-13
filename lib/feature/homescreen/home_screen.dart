import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    bottomTabController.addListener(() {
      print("HomeScreen Current Index ${bottomTabController.index}");
      int currenntIndex = bottomTabController.index;
      bottomTabController.animateTo(currenntIndex);
      setState(() {});
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<WatchScreenProvider>(context, listen: false);

    return WillPopScope(onWillPop: () async {
      if (bottomTabController.index == 0) {
        return true;
      }else if(bottomTabController.index != 0){
        bottomTabController.animateTo(bottomTabController.index-1);
        return false;
      }
      return true;
    }, child: OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
          bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
          // bottomNavigationBar: _bottomNavBar(),
          backgroundColor: Palette.backgroundColor,
          body: CustomPaint(
            child: TabBarView(
                controller: bottomTabController,
                physics: ScrollPhysics(),
                // physics: NeverScrollableScrollPhysics(),
                children: const <Widget>[
                  Center(child: Text("Page 1 Not Found")),
                  WatchScreen(),
                  Center(child: Text("Page 3 Not Found")),
                  Center(child: Text("Page 4 Not Found")),
                ]),
          ));
    }));
  }

  Widget _bottomNavBar() {
    return Container(
      height: 75,
      child: ClipRRect(
        borderRadius:
            // const BorderRadius.only(topRight: Radius.circular(27), topLeft: Radius.circular(27)),
            BorderRadius.circular(27),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/dashboard_icon.svg"),
                label: "Dashboard",
                backgroundColor: Palette.primary),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/play_button_icon.svg"),
                label: "Watch",
                backgroundColor: Palette.primary),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/folder_icon.svg"),
                label: "Media Library",
                backgroundColor: Palette.primary),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/List.svg",
                ),
                label: "More",
                backgroundColor: Palette.primary),
          ],
          unselectedItemColor: Palette.iconColor,
          showUnselectedLabels: true,
          unselectedLabelStyle:  TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400),
          currentIndex: 2,
          enableFeedback: false,

          selectedLabelStyle:  TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700),
          selectedItemColor: Colors.white,
          iconSize: 24,
          selectedFontSize: 12,
          unselectedFontSize: 12,
        ),
      ),
    );
  }
}
