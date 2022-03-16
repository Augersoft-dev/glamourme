import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glamourme/view/home/home.dart';
import 'package:glamourme/view/style.dart';

import '../../model/onboarding_content.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
            primaryColor,
            Colors.black
          ])
        ),
        child: Flexible(
          child: Column(
            children: [
              SizedBox(height: height*.3,),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 55,vertical: 40),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            contents[i].image,
                            height: height*.25,
                          ),
                          const SizedBox(height: 15,),
                          Text(
                            contents[i].title,
                            textAlign: TextAlign.center,
                            style: splashTitleTextStyle()
                          ),
                          const SizedBox(height: 15),
                          Text(
                            contents[i].discription,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: backgroundColor
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                ),
              ),
              CustomBtn(currentIndex: currentIndex, controller: _controller)
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    Key? key,
    required this.currentIndex,
    required PageController controller,
  }) : _controller = controller, super(key: key);

  final int currentIndex;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.all(40),
      width: double.infinity,
      child: FlatButton(
        child: Text(
            currentIndex == contents.length - 1 ? "Continue" : "Next", style: buttonTextStyle(),),
        onPressed: () {
          if (currentIndex == contents.length - 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomePage()),
              
            );
          }
          _controller.nextPage(
            duration: const Duration(milliseconds: 100),
            curve: Curves.bounceIn,
          );
        },
        color: Theme.of(context).primaryColor,
        textColor: buttonTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRoundCorner),
        ),
      ),
    );
  }
}