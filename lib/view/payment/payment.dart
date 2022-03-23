import 'package:flutter/material.dart';
import 'package:glamourme/utils/style.dart';
import 'package:glamourme/view/widgets/custom_btn.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Image(image: AssetImage('assets/images/card.png'),
        width: width,
        height: height*.25,
        fit: BoxFit.fill,
        ),
        SizedBox(height: padding,)
        ,SizedBox(
      height: customContainerHeight,
      //margin: const EdgeInsets.all(40),
      width: double.infinity,
      child: FlatButton(
        child: const Text(
            'Payment Method'),
        onPressed: (){},
        color: whiteColor,
        textColor: buttonTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    )
      ],
    );
  }
}