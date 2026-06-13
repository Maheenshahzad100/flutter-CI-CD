import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:maheen_flutter_practice/Auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title:"Discover Your Style",
          body: "Explore thousands of top-rated products curated just for you.",
          image: Image.network(height:250,'https://png.pngtree.com/png-vector/20251120/ourmid/pngtree-3d-yellow-receipt-with-green-checkmark-and-colorful-confetti-png-image_18013086.webp'),
          decoration: PageDecoration(
            pageColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(color: Colors.black, fontSize: 15, ),
            titlePadding:EdgeInsets.all(8),
            imagePadding: EdgeInsets.all(0)
          )
        ),
         PageViewModel(
          title:"Fast & Secure Checkout",
          body: "Shop in seconds with trusted payment methods and save your favorites.",
             image: Image.network(height:250,'https://static.vecteezy.com/system/resources/thumbnails/073/275/050/small/yellow-check-mark-3d-icon-isolated-on-transparent-background-symbolizing-approval-success-or-completion-with-glossy-finish-and-modern-style-conveying-positivity-and-achievement-png.png'),
          decoration: PageDecoration(
            pageColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(color: Colors.black, fontSize: 15, ),
            titlePadding:EdgeInsets.all(8),
            imagePadding: EdgeInsets.all(0)
          )
        ),
         PageViewModel(
          title:"Free & Fast Delivery",
          body: "Get your items delivered to your doorstep with real-time tracking.",
        image: Image.network(height:250,'https://static.vecteezy.com/system/resources/thumbnails/075/783/454/small/fast-delivery-van-icon-black-and-yellow-color-side-view-simple-flat-design-speed-lines-transportation-express-shipping-modern-isolated-on-transparency-background-png.png'),
          decoration: PageDecoration(
            pageColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(color: Colors.black, fontSize: 15, ),
            titlePadding:EdgeInsets.all(8),
            imagePadding: EdgeInsets.all(0)
          )
        )
      ],
      onSkip: () async{
        final SharedPreferences prefs=await SharedPreferences.getInstance();
        prefs.setBool('isFirst', false);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      },
      onDone:  ()async {
        final SharedPreferences prefs=await SharedPreferences.getInstance();
          prefs.setBool('isFirst', false);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      },
      showBackButton: true,
      showSkipButton: true,
      showNextButton: true,
    skipOrBackFlex: 0,
      nextFlex: 0,
      back:  Icon(Icons.arrow_back, color:Colors.black),
      skip: Text("Skip", style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
      done:  Text("Done", style:TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
            next:  Icon(Icons.arrow_forward, color:Colors.black),
            curve: Curves.fastLinearToSlowEaseIn,
            dotsDecorator:DotsDecorator(
              color: Colors.black,
              activeColor: Colors.black,
              size: Size(10, 10),
              activeSize: Size(22, 10),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(25))
            ) ,

dotsContainerDecorator: BoxDecoration(
  color: Colors.amber[300]
)

    );
  }
}