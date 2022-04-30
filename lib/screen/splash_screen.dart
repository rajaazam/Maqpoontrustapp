

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maqpoon_trust/screen/welcome_screen.dart';
import 'package:maqpoon_trust/utils/size_config.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    Future.delayed(const Duration(milliseconds: 3000), () {

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );

    });

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    /*final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    splashProvider.goToNextScreen(context);*/

    return Scaffold(
      backgroundColor: Color(0xFF0060AE),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.3,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                        color: Color(0xFF0071BC),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(width: SizeConfig.screenWidth * 0.26,),
                        Text('Welcome to'.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 18),),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: SizeConfig.screenHeight * 0.03,),

              Row(
                children: [
                  SizedBox(width: SizeConfig.screenWidth * 0.26,),
                  Text('Alkhidmat'.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 32),),
                ],
              ),

              Row(
                children: [
                  SizedBox(width: SizeConfig.screenWidth * 0.26,),
                  Text('foundation'.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 32),),
                ],
              ),

              Row(
                children: [
                  SizedBox(width: SizeConfig.screenWidth * 0.26,),
                  Text('lahore'.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 32),),
                ],
              ),


            ],
          ),

          /*SvgPicture.asset(
            'assets/images/splash_bg.svg',
          ),*/

          Image.asset(
            'assets/images/splash_bg.png'
          ),

        ],
        
      ),
    );
  }
}
