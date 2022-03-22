import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glamourme/view/chat/chat.dart';
import 'package:glamourme/view/map/map.dart';
import 'package:glamourme/view/overview/overview.dart';
import 'package:glamourme/view/profile/profile.dart';
import 'package:glamourme/view/style.dart';

import '../home/home.dart';

class NavigationPage extends StatefulWidget {
  //final User user;
  const NavigationPage({
     Key? key,
    //this.user,
  }) : super(key: key);
  @override
  createState() => _NavigationPageState(
      //user,
      );
}

class _NavigationPageState extends State<NavigationPage> {

  late PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        children: const <Widget>[
          HomePage(),
          HomePage(),
          // MapPage(),
          ChatPage(),
          OverviewPage(),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: containerRoundCorner, vertical: 10),
          child: CupertinoTabBar(
              border: Border(top: BorderSide(color: blackColor)),
              backgroundColor: blackColor,
              currentIndex: pageIndex,
              onTap: onTap,
              activeColor: primaryColor,
              // inactiveColor: Colors.grey,
              items: [
                BottomNavigationBarItem(icon: Image.asset('assets/icons/home.png',width: 24,height: 24,color: pageIndex==0?primaryColor:Colors.grey,),label: 'Home'),
                BottomNavigationBarItem(icon: Image.asset('assets/icons/map.png',width: 24,height: 24,color: pageIndex==1?primaryColor:Colors.grey,),label: 'Map'),
                BottomNavigationBarItem(icon: Image.asset('assets/icons/chat.png',width: 24,height: 24,color: pageIndex==2?primaryColor:Colors.grey,),label: 'Chat'),
                BottomNavigationBarItem(icon: Image.asset('assets/icons/profile.png',width: 24,height: 24,color: pageIndex==3?primaryColor:Colors.grey,),label: 'Profile'),
              ]),
        ),
      ),
    );
  }
}