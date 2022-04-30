import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maqpoon_trust/models/all_categories_response.dart';
import 'package:maqpoon_trust/utils/app_constants.dart';
import 'package:maqpoon_trust/utils/utils.dart';


class AllCategoriesService {

  Future<AllCategoriesResponse> allCategoriesApiCall(BuildContext context) async {

    try {

      final response = await http.get(
        Uri.parse('${AppConstants.baseURL}/CategoryApi'),
        headers: {
          "Accept": "application/json",
        },
      );

      print('all categories response: ${response.body}');

      final item = json.decode(response.body);
      AllCategoriesResponse result = AllCategoriesResponse.fromJson(item);

      if (response.statusCode == 200) {

        return result;
      } else {

        print('in else');
        Utils.toast('Error: ${response.statusCode}');

      }


    } on SocketException {

      //no internet
      Utils.toast('Not connected to internet !');

      return AllCategoriesResponse();
    } catch(e) {

      print('all categories error: $e');
      Utils.toast('all categories error: $e');

      return AllCategoriesResponse();
    }

    return AllCategoriesResponse();
  }


}