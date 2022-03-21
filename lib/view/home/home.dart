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
          child: SingleChildScrollView(
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
                CatagoryWidget(height: height, width: width),
                SizedBox(
                  height: padding,
                ),
                Text('Hair Specialist',style: titleTextStyle(),),
                //  SizedBox(
                //   height: padding,
                // ),
               GridView.builder(  
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,  
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  
                  crossAxisCount: 2,  
                  crossAxisSpacing: 15,  
                  mainAxisSpacing: 10  
              ),  
              itemBuilder: (BuildContext context, int index){  
                return SpecialistOverview(height: height, width: width);  
              },  
            ), 
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpecialistOverview extends StatelessWidget {
  const SpecialistOverview({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(containerRoundCorner),
        color: secondaryLightColor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 97,
            width: width,
            decoration: const BoxDecoration(

              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/img.png'))
            ),
          ),

          Container(
            height: 63,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(containerRoundCorner),
                topRight: Radius.circular(containerRoundCorner),
                
              ),
              color: whiteColorWithOpacity
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              child: Column(
                children: [
                  Text('Specialist Name', style: brownTitleTextStyle(),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,),
                  Text('Hair Specialist',style: brownSubtitleTextStyle(),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,),
                ],
              ),
            )
          ),
          
        ],
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
