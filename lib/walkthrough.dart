import 'package:barber_homepro/login.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreenClass extends StatelessWidget {
  final List<Slide> slides = [
    new Slide(
      title: "APARTMENT",
      description: "Need an apartment to stay in or rent out?",
      pathImage: "assets/image/slider_house.png",
      backgroundColor: Color(0xff454dff),
      heightImage: 70.00,
      widthImage: 70.00
    ),
    new Slide(
      title: "SAFE & SECURE",
      description: "Need a secure and safe apartment?",
      pathImage: "assets/image/slider_safe.png",
      backgroundColor: Color(0xff454dff),
      heightImage: 70.00,
      widthImage: 70.00
    ),
    new Slide(
      title: "PROFESSIONAL",
      description:
          "Need a proffessional assistance in finding or renting an apartment?",
      pathImage: "assets/image/slider_verified.png",
      backgroundColor: Color(0xff454dff),
      heightImage: 70.00,
      widthImage: 70.00
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginClass()),
        );
      },
      onSkipPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginClass()),
        );
      },
    );
  }
}
