import 'package:flutter/material.dart';
import 'package:glamourme/view/shedule/set_shedule.dart';
import 'package:glamourme/view/style.dart';
import 'package:glamourme/view/widgets/custom_btn.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        title: Text("Set Shedule",style: titleTextStyle(),),
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios),color: blackColor,),
      ),
      backgroundColor: backgroundColor,
      body: Stepper(
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepContinue: () {
                    final isLastStep = currentStep == getSteps().length - 1;
                    if (isLastStep) {
                      // send data to server
                    } else {
                      setState(() => currentStep += 1);
                    }
                  },
                  onStepCancel: () {
                    currentStep == 0?null:setState(() => currentStep -= 1);
                  },
                  steps: getSteps())
    );
  }

  List<Step> getSteps() {
    return [
      Step(
          isActive: currentStep >= 0,
          title: Text('Shedule'),
          content: SetShedulePage()),
      Step(
          isActive: currentStep >= 1,
          title: Text('Payment'),
          content: Text("")),
      Step(isActive: currentStep >= 2, title: Text('Finsih'), content: Text(""))
    ];
  }
}
