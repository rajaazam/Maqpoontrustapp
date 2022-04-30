
import 'package:flutter/material.dart';
import 'package:maqpoon_trust/models/request_for_help_data.dart';
import 'package:maqpoon_trust/models/request_for_help_response.dart';
import 'package:maqpoon_trust/services/request_for_help_service.dart';
import 'package:maqpoon_trust/utils/utils.dart';


class RequestForHelpProvider with ChangeNotifier {

  RequestForHelpResponse requestForHelpResponse = RequestForHelpResponse();
  bool loading = false;

  getRequestForHelpResponse(BuildContext context, RequestForHelpData requestForHelpData) async {

    showLoading();

    RequestForHelpService requestForHelpService = RequestForHelpService();

    requestForHelpResponse = await requestForHelpService.requestForHelpApiCall(context, requestForHelpData);

    hideLoading();

    if(requestForHelpResponse.status!) {

      Utils.toast(requestForHelpResponse.message!);

      Navigator.pop(context);
    }
    else {
      Utils.toast(requestForHelpResponse.message!);
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


