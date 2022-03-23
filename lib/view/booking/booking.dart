import 'package:flutter/material.dart';
import 'package:glamourme/view/payment/payment.dart';
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
  bool isComplete= false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0.0,
          title: Text(
            "Set Shedule",
            style: titleTextStyle(),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
            color: blackColor,
          ),
        ),
        backgroundColor: backgroundColor,
        body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: secondaryColor)),
          child: Stepper(
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  setState(() {
                    isComplete=true;
                  });
                  // send data to server
                } else {
                  setState(() => currentStep += 1);
                }
              },
              onStepCancel: () {
                currentStep == 0 ? null : setState(() => currentStep -= 1);
              },
              onStepTapped: (step) => setState(() {
                    currentStep = step;
                  }),
              controlsBuilder: (context, details) {
                final isLastStep = currentStep == getSteps().length - 1;
                return Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      // CustomBtn(text: "Continue", onPress: ()=>details.onStepContinue),
                      Expanded(
                        child: Container(
                          height: customContainerHeight,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(containerRoundCorner),
                            color: primaryColor
                          ),
                          child: TextButton(
                              onPressed: details.onStepContinue,
                              child: Text(isLastStep?'Finish':'Continue',style: buttonTextStyle(),)),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      if(currentStep!=0)
                      Expanded(
                        child: Container(
                          height: customContainerHeight,
                          width: width,
                           decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(containerRoundCorner),
                            color: primaryColor
                          ),
                          child: TextButton(
                              onPressed: details.onStepCancel,
                              child: Text('Cancel')),
                        ),
                      )
                    ],
                  ),
                );
              },
              steps: getSteps()),
        ));
  }

  List<Step> getSteps() {
    return [
      Step(
          state: currentStep >= 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Shedule'),
          content: SetShedulePage()),
      Step(
          state: currentStep >= 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Payment'),
          content: PaymentPage()),
      Step(
          state: currentStep >= 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text('Finish'),
          content: Text(""))
    ];
  }
}
