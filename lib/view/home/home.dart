import 'package:flutter/material.dart';
import 'package:glamourme/view/style.dart';

import '../widgets/ads_widget.dart';
import '../widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [backgroundColor, whiteColor])),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              SizedBox(
                height: padding,
              ),
              SearchWidget(width: width),
              SizedBox(
                height: padding,
              ),
              AdsWidget(width: width),
              SizedBox(
                height: padding,
              ),
              Text('Catagory',style: titleTextStyle(),),
              SizedBox(
                height: padding,
              ),
              CatagoryWidget(height: height, width: width)
            ],
          ),
        ),
      ),
    );
  }
}

class CatagoryWidget extends StatelessWidget {
  const CatagoryWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
      height: height*.1,
      width: width*.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(containerRoundCorner),
        color: backgroundColor
      ),
      child: Center(
        child: Image.asset('assets/icons/png/Asset 181.png',width: width*.15,height: height*.06,),
      ),
    ),
    Container(
      height: height*.1,
      width: width*.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(containerRoundCorner),
        color: backgroundColor
      ),
      child: Center(
        child: Image.asset('assets/icons/png/Asset 291.png',width: width*.15,height: height*.06,),
      ),
    ),
    Container(
      height: height*.1,
      width: width*.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(containerRoundCorner),
        color: backgroundColor
      ),
      child: Center(
        child: Image.asset('assets/icons/png/Asset 251.png',width: width*.15,height: height*.06,),
      ),
    ),
    Container(
      height: height*.1,
      width: width*.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(containerRoundCorner),
        color: backgroundColor
      ),
      child: Center(
        child: Image.asset('assets/icons/png/Asset 321.png',width: width*.15,height: height*.06,),
      ),
    )
      ],
    );
  }
}


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(containerRoundCorner)),
        child: Center(
          child: Image.asset(
            'assets/icons/profile.png',
            width: 24,
            height: 24,
          ),
        ),
      ),
      title: ListTile(
        title: Text(
          'Hi, User name',
          style: titleTextStyle(),
          textAlign: TextAlign.center,
        ),
        subtitle: Text('choose your hair style',
            style: descriptionTextStyle(), textAlign: TextAlign.center),
      ),
      actions: [
        Container(
          height: 44,
          width: 55,
          decoration: BoxDecoration(
              color: whiteColor, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Image.asset(
              'assets/icons/notification.png',
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }
}
