class RequestRecordsResponse {

  bool? status;
  String? messages;
  List<RequestRecordsData>? data;

  RequestRecordsResponse({this.status, this.messages, this.data});

  RequestRecordsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    if (json['data'] != null) {
      data = <RequestRecordsData>[];
      json['data'].forEach((v) {
        data!.add(RequestRecordsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestRecordsData {
  String? id;
  String? fullName;
  String? cnic;
  String? fatherCnic;
  String? phoneNumber;
  String? category;
  String? help;
  String? careOf;
  String? status;
  String? amount;
  String? createdAt;
  String? updatedAt;
  String? categoryName;

  RequestRecordsData(
      {this.id,
        this.fullName,
        this.cnic,
        this.fatherCnic,
        this.phoneNumber,
        this.category,
        this.help,
        this.careOf,
        this.status,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.categoryName});

  RequestRecordsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    cnic = json['cnic'];
    fatherCnic = json['father_cnic'];
    phoneNumber = json['phone_number'];
    category = json['category'];
    help = json['help'];
    careOf = json['care_of'];
    status = json['status'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['cnic'] = this.cnic;
    data['father_cnic'] = this.fatherCnic;
    data['phone_number'] = this.phoneNumber;
    data['category'] = this.category;
    data['help'] = this.help;
    data['care_of'] = this.careOf;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_name'] = this.categoryName;
    return data;
  }
}
