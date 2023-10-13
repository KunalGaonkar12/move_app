import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../common/constants/palette.dart';

class CustomBottomBar extends StatefulWidget {
  final TabController controller;

  const CustomBottomBar({
    required this.controller,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  Color selectedColor = Palette.textColor;
  Color unselectedColor = Palette.iconColor;

  int _currentIndex = 0;

  @override
  void initState() {
    widget.controller.addListener(() {
      print(" WatchScreen Current Index ${ widget.controller.index}");
        int currentIndex=widget.controller.index;
      _currentIndex=currentIndex;
      widget.controller.animateTo(currentIndex);
      setState(() {});
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> homeScreenItems = [
      bottomBarItem(
          label: "Dashboard",
          imagePath: "assets/icons/dashboard_icon.svg",
          dimention: 16,
          iconSpacer: 9,
          textColor: _currentIndex == 0 ? selectedColor : unselectedColor,
          fontWeight: _currentIndex == 0 ? FontWeight.w700 : FontWeight.w400,
          animationIndex: 0),
      bottomBarItem(
          label: "Watch",
          imagePath: "assets/icons/play_button_icon.svg",
          dimention: 18,
          iconSpacer: 9,
          textColor: _currentIndex == 1 ? selectedColor : unselectedColor,
          fontWeight: _currentIndex == 1 ? FontWeight.w700 : FontWeight.w400,
          animationIndex: 1),
      bottomBarItem(
          label: "Media Library",
          imagePath: "assets/icons/folder_icon.svg",
          dimention: 18,
          iconSpacer: 9,
          textColor: _currentIndex == 2 ? selectedColor : unselectedColor,
          fontWeight: _currentIndex == 2 ? FontWeight.w700 : FontWeight.w400,
          animationIndex: 2),
      bottomBarItem(
          label: "More",
          imagePath: "assets/icons/List.svg",
          dimention: 24,
          iconSpacer: 4,
          textColor: _currentIndex == 3 ? selectedColor : unselectedColor,
          fontWeight: _currentIndex == 3 ? FontWeight.w700 : FontWeight.w400,
          animationIndex: 3),
    ];

    return Container(
      height: 75,
      child: ClipRRect(
        borderRadius:
            const BorderRadius.only(topRight: Radius.circular(27), topLeft: Radius.circular(27)),
            // BorderRadius.circular(27),
        child: BottomAppBar(
          color: Palette.primary,
          height: 75,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: homeScreenItems,
                )),
          ),
        ),
      ),
    );
  }

  Widget bottomBarItem<StatefulWidget>({
    required String label,
    required String imagePath,
    required double dimention,
    required double iconSpacer,
    Color textColor = Palette.iconColor,
    Color iconColor = Colors.transparent,
    required int animationIndex,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GestureDetector(
      onTap: () {
        widget.controller.animateTo(animationIndex);
        setState(() {
          _currentIndex = animationIndex;
        });
      },
      child: SizedBox(
        child: Column(
          children: [
            SvgPicture.asset(
                imagePath,
              color: textColor,width: dimention,height: dimention,
            ),
            SizedBox(
              height: iconSpacer,
            ),
            Expanded(
                child: Text(
              label,
              style: TextStyle(
                  fontFamily: "Roboto",
                  color: textColor,
                  fontSize: 12,
                  fontWeight: fontWeight),
            ))
          ],
        ),
      ),
    );
  }
}
