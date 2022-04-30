import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maqpoon_trust/models/request_records_response.dart';
import 'package:maqpoon_trust/utils/app_constants.dart';
import 'package:maqpoon_trust/utils/utils.dart';


class RequestRecordsService {

  Future<RequestRecordsResponse> allRequestRecordsApiCall(BuildContext context) async {

    try {

      final response = await http.get(
        Uri.parse('${AppConstants.baseURL}/RequestApi'),
        headers: {
          "Accept": "application/json",
        },
      );

      print('request records response: ${response.body}');

      final item = json.decode(response.body);
      RequestRecordsResponse result = RequestRecordsResponse.fromJson(item);

      if (response.statusCode == 200) {

        return result;
      } else {

        print('in else');
        Utils.toast('Error: ${response.statusCode}');
      }


    } on SocketException {

      //no internet
      Utils.toast('Not connected to internet !');

      return RequestRecordsResponse();
    } catch(e) {

      print('request records error: $e');
      Utils.toast('request records error: $e');

      return RequestRecordsResponse();
    }

    return RequestRecordsResponse();
  }


}