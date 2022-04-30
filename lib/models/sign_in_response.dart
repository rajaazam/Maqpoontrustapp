class SignInResponse {

  bool? status;
 
  String? message;

  SignInResponse({this.status, this.message});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['messages'] = message;
    return data;
  }

}