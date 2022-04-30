class AllCategoriesResponse {

  bool? status;
  String? messages;
  List<CategoryData>? data;

  AllCategoriesResponse({this.status, this.messages, this.data});

  AllCategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    messages = json['messages'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['messages'] = messages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  String? id;
  String? name;
  String? createdAt;

  CategoryData({this.id, this.name, this.createdAt});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    return data;
  }
}
