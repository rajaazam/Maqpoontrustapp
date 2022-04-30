
import 'package:flutter/material.dart';
import 'package:maqpoon_trust/screen/donate_screen.dart';
import 'package:maqpoon_trust/screen/request_screen.dart';
import 'package:maqpoon_trust/screen/sign_in_screen.dart';
import 'package:maqpoon_trust/screen/sign_up_screen.dart';
import 'package:maqpoon_trust/utils/size_config.dart';
import 'package:maqpoon_trust/widgets/blue_btn.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  final Decoration kBlueBtnDecoration = const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF0073D1),
        Color(0xFF005398),
      ],
      stops: [0.0, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.clamp,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  );


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          
          //this container has been added to give the white background in the stack
          //because image has no background color
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            color: Colors.white,
          ),

          Positioned(
            left: -60,
            bottom: -40,
            child: Image.asset(
              'assets/images/bg1.png',
              width: SizeConfig.screenWidth * 1.2,
            ),
          ),

          //main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              //top space
              SizedBox(
                height: SizeConfig.screenHeight * 0.12,
              ),
              
              //logo image
              _logoImage(),
              
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              
              _buttons(context),
              // RichText(
              //             text: TextSpan(children: [
              //           const TextSpan(
              //               text: 'If you not register ?',
              //               style: TextStyle(color: Colors.black)),
              //           TextSpan(
              //               text: 'SIHN UP',
              //               style: TextStyle(color: orangeLightColors))
              //         ]))

            ],
          ),
        ],
      ),
    );
  }

  Widget _logoImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.25,
          child: Image.asset('assets/images/logo.png'),
        ),
      ],
    );
  }

  Widget _buttons(BuildContext context) {
    return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'need any help?',
                    style: TextStyle(
                        fontSize: 16, color: Colors.grey.withOpacity(0.6)),
                  ),

                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),

                  //request for help button
                  /*InkWell(
                    onTap: () {
                      print('request for help button tapped');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RequestScreen()),
                      );
                    },
                    child: Container(
                      width: SizeConfig.screenWidth * 0.80,
                      padding: const EdgeInsets.all(24),
                      decoration: kBlueBtnDecoration,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'request for help'.toUpperCase(),
                            style: blueBtnTextStyle,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),*/

                  BlueBtn(kBlueBtnDecoration: kBlueBtnDecoration, text: 'request for help', callback: () {
                      print('request for help button tapped');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RequestScreen()),
                      );

                  },),
                  
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),

                  //admin login button
                  BlueBtn(kBlueBtnDecoration: kBlueBtnDecoration, text: 'admin login', callback: () {

                    print('admin login button tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignInScreen()),
                    );
                    
                  },),

                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),

                  //admin signup button
                  BlueBtn(kBlueBtnDecoration: kBlueBtnDecoration, text: 'SIGN UP', callback: () {

                    print('admin Sign Up button tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpScreen()),
                    );
                    
                  },),
                    SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  //donate now button
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DonateScreen()),
                      );
                    },
                    child: Container(
                      width: SizeConfig.screenWidth * 0.80,
                      padding: EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFFD991F),
                            const Color(0xFFEF6800),
                          ],
                          stops: [0.0, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          tileMode: TileMode.clamp,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'donate now'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            );
  }
  
}
