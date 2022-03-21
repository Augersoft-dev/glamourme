


import 'package:flutter/material.dart';
import 'package:glamourme/view/style.dart';
import 'package:glamourme/view/widgets/custom_btn.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("Flexible Appbar"),
              pinned: true,
              expandedHeight: 210.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: height*.4,
                  decoration: BoxDecoration(
                    color: primaryColor
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Text('Specialist name', style: titleTextStyle(),),
                  Row(children: [
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    SizedBox(width: 10,),
                    Text('4.5 reviews')
                  ],),
                  Row(
                    children: [Icon(Icons.pin_drop),Text('Location ',style: descriptionBlackTextStyle(),)],
                  ),
                  Row(
                    children: [Icon(Icons.watch_later),Text('Available 00:00PM to 00:00',style: descriptionTextStyle(),)],
                  ),
                  Text('very professional service and various discount on Fridays and various interesting tools for your hair. We are waiting for you to order now',style: descriptionTextStyle(),)
                  ,Text('Catagory',style: titleTextStyle(),),
                SizedBox(
                  height: padding,
                ),
                CatagoryWidget(height: height, width: width),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBtn(text: 'Book Now', onPress: (){})
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



