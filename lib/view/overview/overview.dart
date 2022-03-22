import 'package:flutter/material.dart';
import 'package:glamourme/view/booking/booking.dart';
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios),
                    color: whiteColor,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert),
                    color: whiteColor,
                  ),
                ],
              ),
              // title: ListTile(
              //   leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios),color: whiteColor,),
              //   trailing: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert),color: whiteColor,),
              // ),

              pinned: true,
              expandedHeight: height * .4,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: height * .4,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      image: const DecorationImage(
                          image: AssetImage('assets/images/img.png'))),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Specialist name',
                          style: titleTextStyle(),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 15,
                              color: primaryColor,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: primaryColor,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: primaryColor,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: primaryColor,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('4.5 reviews')
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.pin_drop,
                              color: blackLightColor,
                              size: 21,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Location ',
                              style: descriptionTextStyle(),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later,
                              color: blackLightColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Available 00:00PM to 00:00',
                              style: descriptionTextStyle(),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'very professional service and various discount on Fridays and various interesting tools for your hair. We are waiting for you to order now',
                          style: descriptionTextStyle(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Catagory',
                          style: titleTextStyle(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CatagoryWidget(height: height, width: width),
                         SizedBox(
                          height: padding,
                        ),
                        CustomBtn(text: 'Book Now', onPress: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingPage()))),
                         SizedBox(
                          height: padding+padding+padding,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ), );
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
          height: height * .1,
          width: width * .2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(containerRoundCorner),
              color: backgroundColor),
          child: Center(
            child: Image.asset(
              'assets/icons/png/Asset 181.png',
              width: width * .15,
              height: height * .06,
            ),
          ),
        ),
        Container(
          height: height * .1,
          width: width * .2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(containerRoundCorner),
              color: backgroundColor),
          child: Center(
            child: Image.asset(
              'assets/icons/png/Asset 291.png',
              width: width * .15,
              height: height * .06,
            ),
          ),
        ),
        Container(
          height: height * .1,
          width: width * .2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(containerRoundCorner),
              color: backgroundColor),
          child: Center(
            child: Image.asset(
              'assets/icons/png/Asset 251.png',
              width: width * .15,
              height: height * .06,
            ),
          ),
        ),
        Container(
          height: height * .1,
          width: width * .2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(containerRoundCorner),
              color: backgroundColor),
          child: Center(
            child: Image.asset(
              'assets/icons/png/Asset 321.png',
              width: width * .15,
              height: height * .06,
            ),
          ),
        )
      ],
    );
  }
}
