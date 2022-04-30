

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:maqpoon_trust/models/donate_now_data.dart';
import 'package:maqpoon_trust/models/donate_now_response.dart';
import 'package:maqpoon_trust/utils/app_constants.dart';
import 'package:maqpoon_trust/utils/utils.dart';
import 'package:http/http.dart' as http;

class DonateNowService {

  Future<DonateNowResponse> donateNowApiCall(BuildContext context, DonateNowData donateNowData) async {

    try {

      final response = await http.post(
        Uri.parse('${AppConstants.baseURL}/DonateNowApi/create'),
        body: {
          "full_name": donateNowData.fullName,
          "phone_number": donateNowData.phoneNo,
          "email": donateNowData.email,
          "amount": donateNowData.amount,
          "category": donateNowData.category,
        },
        headers: {"Accept": "application/json"},
      );

      final responseJson = jsonDecode(response.body);
      DonateNowResponse donateNowResponse = DonateNowResponse.fromJson(responseJson);

      print('donate now response: ${response.body}');


      if (donateNowResponse.message == '') {

        return donateNowResponse;
      }
      else if (donateNowResponse.status == true) {

        return donateNowResponse;
      } else {

        //something went wrong
        print(donateNowResponse.message);
        Utils.toast(donateNowResponse.message!);

        return DonateNowResponse();
      }
    } on SocketException {
      //no internet

      Utils.toast('Not connected to internet !');

      return DonateNowResponse();
    }
    catch(e) {

      print(e.toString());
      Utils.toast(e.toString());

      return DonateNowResponse();
    }
  }


}