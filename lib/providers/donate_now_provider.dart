
import 'package:flutter/material.dart';
import 'package:maqpoon_trust/models/donate_now_data.dart';
import 'package:maqpoon_trust/models/donate_now_response.dart';
import 'package:maqpoon_trust/services/donate_now_service.dart';
import 'package:maqpoon_trust/utils/utils.dart';


class DonateNowProvider with ChangeNotifier {

  DonateNowResponse donateNowResponse = DonateNowResponse();
  bool loading = false;

  getDonateNowResponse(BuildContext context, DonateNowData donateNowData) async {

    showLoading();

    DonateNowService donateNowService = DonateNowService();

    donateNowResponse = await donateNowService.donateNowApiCall(context, donateNowData);

    hideLoading();

    if(donateNowResponse.status!) {

      Utils.toast(donateNowResponse.message!);

      Navigator.pop(context);
    }
    else {
      Utils.toast(donateNowResponse.message!);
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


