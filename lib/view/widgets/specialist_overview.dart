import 'package:flutter/material.dart';
import 'package:glamourme/view/style.dart';

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

              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   image: AssetImage('assets/images/img.png'))
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