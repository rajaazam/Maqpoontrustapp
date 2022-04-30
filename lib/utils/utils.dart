
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'app_constants.dart';
import 'color_constants.dart';

class Utils {

  static List<String> monthsAdded = [];

  static navigateToScreen(BuildContext context, 
  String routeName, Widget screen, bool withNavbar, {String? email}) {

  }

  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  static Widget loadingIndicator() {
    return const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.logoColor));
  }

  static toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );

  }

  static Widget setSvgImg(String path, double width, double height, Color color) {
    return SvgPicture.asset(
      path,
      /*width: width,
      height: height,*/
      //color: color,
    );
  }




}