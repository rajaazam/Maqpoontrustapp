
import 'package:flutter/material.dart';
import 'package:maqpoon_trust/models/request_records_response.dart';
import 'package:maqpoon_trust/services/request_records_service.dart';
import 'package:maqpoon_trust/services/search_request_record_service.dart';
import 'package:maqpoon_trust/utils/utils.dart';


class RequestRecordsProvider with ChangeNotifier {

  RequestRecordsResponse requestRecordsResponse = RequestRecordsResponse();

  List<RequestRecordsData>? recordsList = [];
  bool loading = false;

  Future<void> getRequestRecordsResponse(BuildContext context) async {

    recordsList = [];

    RequestRecordsService requestRecordsService = RequestRecordsService();

    showLoading();

    requestRecordsResponse = await requestRecordsService.allRequestRecordsApiCall(context);

    hideLoading();

    if(requestRecordsResponse.status!) {

      //Utils.toast(clientsResponse.message!);
      recordsList = requestRecordsResponse.data!;
    }
    else {

      print('${requestRecordsResponse.messages!}');
      Utils.toast(requestRecordsResponse.messages!);
    }

    notifyListeners();
  }

  Future<void> getSearchRequestRecordResponse(BuildContext context, String cnic) async {

    recordsList = [];

    SearchRequestRecordService searchRequestRecordService = SearchRequestRecordService();

    showLoading();

    requestRecordsResponse = await searchRequestRecordService.searchRequestRecordApiCall(context, cnic);

    hideLoading();

    if(requestRecordsResponse.status!) {

      recordsList = requestRecordsResponse.data!;
    }
    else {

      print('${requestRecordsResponse.messages!}');
      Utils.toast(requestRecordsResponse.messages!);
    }

    notifyListeners();
  }



  getCategoriesListLength() {
    return requestRecordsResponse.data!.length;
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