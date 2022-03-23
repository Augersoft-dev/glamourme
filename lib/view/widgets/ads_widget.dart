import 'package:flutter/material.dart';
import 'package:glamourme/utils/style.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(containerRoundCorner),
            gradient: LinearGradient(
                colors: [buttonTextColor, blackColor])),
        child: Padding(
            padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('5% for new customers',style: adsTextStyle(),),
                      subtitle: Text('discount only 2 days',style: descriptionTextStyle(),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(buttonRoundCorner),
                          color: primaryColor
                        ),
                        child: Center(
                          child: Text('Book now'.toUpperCase(),style: TextStyle(color: buttonTextColor,fontWeight: FontWeight.w500),),
                        ),
                      ),
                    )
                  ],
                ),
                ));
  }
}