import 'dart:convert';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:maqpoon_trust/models/sign_in_response.dart';
import 'package:http/http.dart' as http;
import 'package:maqpoon_trust/utils/app_constants.dart';
import 'package:maqpoon_trust/utils/utils.dart';

class SignInService {
  Future<SignInResponse> signInApiall(BuildContext context,String email,String password) async {

    try{

      final response= await http.post(Uri.parse('${AppConstants.baseURL}/user-login'),
      body: {
        'email':email,
        'password':password,
      },
      headers: {
       "Accepts":"applications/json"
      }
    
      );
      final  responseJson = jsonDecode(response.body);
      SignInResponse signInResponse =SignInResponse.fromJson( responseJson);
       print('sign-in response: ${response.body}');
       if(signInResponse.message=='Email dose not exit'|| signInResponse.message=='password incorrest'){

         return signInResponse;
       }else if(signInResponse.status==true){
        print('log in success');
        return signInResponse;
       }else{
         print(signInResponse.message);
         Utils.toast(signInResponse.message!);
            //something went wrong
        //Utils.toast('Something went wrong !');
         return SignInResponse();
       }
    } on SocketException{
       Utils.toast('No internet connect');
       return SignInResponse();
    }catch(e){
      print(e.toString());
      Utils.toast(e.toString());
      return SignInResponse();

    }
  } 


}