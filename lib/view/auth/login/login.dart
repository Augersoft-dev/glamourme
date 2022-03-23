import 'package:flutter/material.dart';
import 'package:glamourme/utils/style.dart';
import 'package:glamourme/view/widgets/custom_btn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height*.1,),
          ListTile(
            title: Text('Glamourme', textAlign: TextAlign.center, style: TextStyle(color: primaryColor,fontSize: 28,fontWeight: FontWeight.w600),),
            subtitle: Text('we guaranteed your handsome',textAlign: TextAlign.center,style: subTitleTextStyle(),),
            
          ),
          SizedBox(height: height*.1,),
          SizedBox(
      height: customContainerHeight,
      //margin: const EdgeInsets.all(40),
      width: double.infinity,
      child: FlatButton(
        child: Text(
            'text'),
        onPressed: null,
        color: Theme.of(context).primaryColor,
        textColor: buttonTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    )
        ],
      ),
    );
  }
}