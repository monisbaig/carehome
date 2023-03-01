class UserModel {
  int? status;
  String? message;
  Data? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? groupName;
  String? name;
  String? image;
  String? cityId;
  String? postalCode;
  String? address;
  String? contactNumber;
  String? managerName;
  String? managerEmail;
  String? adminName;
  String? adminEmail;
  String? accountantName;
  String? accountantEmail;
  String? hourlyRate;
  String? careHomeRateTypeId;
  Null? paymentTerms;
  Null? website;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? careHomeUserId;

  Data(
      {this.id,
      this.groupName,
      this.name,
      this.image,
      this.cityId,
      this.postalCode,
      this.address,
      this.contactNumber,
      this.managerName,
      this.managerEmail,
      this.adminName,
      this.adminEmail,
      this.accountantName,
      this.accountantEmail,
      this.hourlyRate,
      this.careHomeRateTypeId,
      this.paymentTerms,
      this.website,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.careHomeUserId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
    name = json['name'];
    image = json['image'];
    cityId = json['city_id'];
    postalCode = json['postal_code'];
    address = json['address'];
    contactNumber = json['contact_number'];
    managerName = json['manager_name'];
    managerEmail = json['manager_email'];
    adminName = json['admin_name'];
    adminEmail = json['admin_email'];
    accountantName = json['accountant_name'];
    accountantEmail = json['accountant_email'];
    hourlyRate = json['hourly_rate'];
    careHomeRateTypeId = json['care_home_rate_type_id'];
    paymentTerms = json['payment_terms'];
    website = json['website'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    careHomeUserId = json['care_home_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_name'] = groupName;
    data['name'] = name;
    data['image'] = image;
    data['city_id'] = cityId;
    data['postal_code'] = postalCode;
    data['address'] = address;
    data['contact_number'] = contactNumber;
    data['manager_name'] = managerName;
    data['manager_email'] = managerEmail;
    data['admin_name'] = adminName;
    data['admin_email'] = adminEmail;
    data['accountant_name'] = accountantName;
    data['accountant_email'] = accountantEmail;
    data['hourly_rate'] = hourlyRate;
    data['care_home_rate_type_id'] = careHomeRateTypeId;
    data['payment_terms'] = paymentTerms;
    data['website'] = website;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['care_home_user_id'] = careHomeUserId;
    return data;
  }
}
