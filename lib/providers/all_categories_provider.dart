
import 'package:flutter/material.dart';
import 'package:maqpoon_trust/models/all_categories_response.dart';
import 'package:maqpoon_trust/services/all_categories_service.dart';


class AllCategoriesProvider with ChangeNotifier {

  AllCategoriesResponse allCategoriesResponse = AllCategoriesResponse();

  List<CategoryData>? categoriesList = [];
  List<String>? categoriesStrList = [];
  bool loading = false;

  Future<void> getAllCategoriesResponse(BuildContext context) async {

    categoriesStrList = [];
    AllCategoriesService allCategoriesService = AllCategoriesService();

    showLoading();

    allCategoriesResponse = await allCategoriesService.allCategoriesApiCall(context);

    hideLoading();

    if(allCategoriesResponse.status!) {

      //Utils.toast(clientsResponse.message!);
      categoriesList = allCategoriesResponse.data!;

      for(int i=0; i<categoriesList!.length; i++) {
        categoriesStrList!.add(categoriesList![i].name!);
      }

    }
    else {

      print('${allCategoriesResponse.messages!}');

    }

    notifyListeners();
  }

  getCategoriesListLength() {
    return allCategoriesResponse.data!.length;
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