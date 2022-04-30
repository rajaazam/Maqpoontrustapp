
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maqpoon_trust/screen/welcome_screen.dart';

class SplashProvider with ChangeNotifier {


  goToNextScreen(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () {

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );

    });

  }

}
