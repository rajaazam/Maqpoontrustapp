class DonateNowResponse {

  bool? status;
  String? message;

  DonateNowResponse({this.status, this.message});

  DonateNowResponse.fromJson(Map<String, dynamic> json) {
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
