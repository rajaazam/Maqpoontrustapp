
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maqpoon_trust/models/request_for_help_data.dart';
import 'package:maqpoon_trust/models/request_for_help_response.dart';
import 'package:maqpoon_trust/utils/app_constants.dart';
import 'dart:convert';
import 'dart:io';

import 'package:maqpoon_trust/utils/utils.dart';


class RequestForHelpService {

  Future<RequestForHelpResponse> requestForHelpApiCall(BuildContext context, RequestForHelpData requestForHelpData) async {

    try {

      final response = await http.post(
        Uri.parse('${AppConstants.baseURL}/RequestApi'),
        body: {
          "full_name": requestForHelpData.fullName,
          "cnic": requestForHelpData.cnic,
          "father_cnic": requestForHelpData.fatherCNIC,
          "phone_number": requestForHelpData.phoneNo,
          "category": requestForHelpData.category,
          "help": requestForHelpData.helpNeeded,
          "care_of": requestForHelpData.careOf,
        },
        headers: {"Accept": "application/json"},
      );

      final responseJson = jsonDecode(response.body);
      RequestForHelpResponse requestForHelpResponse = RequestForHelpResponse.fromJson(responseJson);

      print('request for help response: ${response.body}');


      if (requestForHelpResponse.message == '') {

        return requestForHelpResponse;
      }
      else if (requestForHelpResponse.status == true) {

        return requestForHelpResponse;
      } else {

        //something went wrong
        print(requestForHelpResponse.message);
        Utils.toast(requestForHelpResponse.message!);

        return RequestForHelpResponse();
      }
    } on SocketException {
      //no internet

      Utils.toast('Not connected to internet !');

      return RequestForHelpResponse();
    }
    catch(e) {

      print(e.toString());
      Utils.toast(e.toString());

      return RequestForHelpResponse();
    }
  }


}
