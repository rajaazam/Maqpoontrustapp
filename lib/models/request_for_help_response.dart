class RequestForHelpResponse {

  bool? status;
  String? message;

  RequestForHelpResponse({this.status, this.message});

  RequestForHelpResponse.fromJson(Map<String, dynamic> json) {
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
