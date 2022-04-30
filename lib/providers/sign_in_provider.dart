
import 'package:flutter/material.dart';
import 'package:maqpoon_trust/models/sign_in_response.dart';
import 'package:maqpoon_trust/screen/dashboard_screen.dart';
import 'package:maqpoon_trust/services/sign_in_service.dart';
import 'package:maqpoon_trust/utils/utils.dart';



class SignInProvider with ChangeNotifier {

  SignInResponse signInResponse = SignInResponse();
  bool loading = false;

  getSignInResponse(BuildContext context, String email, String password) async {

    SignInService signInService = SignInService();

    showLoading();

    signInResponse = await signInService.signInApiall(context, email, password);

    hideLoading();

    print('status: ${signInResponse.status}');

    if(signInResponse.status!) {

      print(signInResponse.message);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );

    }
    else {
      Utils.toast(signInResponse.message!);
    }

    notifyListeners();
  }

  showLoading() {
    loading = true;
    notifyListeners();
  }

  hideLoading() {
    loading = false;
    notifyListeners();
  }


}
