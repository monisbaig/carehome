class RequestModel {
  int? status;
  String? message;
  List<Data>? data;

  RequestModel({this.status, this.message, this.data});

  RequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? careHomeId;
  String? position;
  String? numberOfStaff;
  String? shiftDetail;
  String? startDate;
  String? endDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? statusName;
  String? shiftDetailName;
  String? positionName;

  Data(
      {this.id,
      this.careHomeId,
      this.position,
      this.numberOfStaff,
      this.shiftDetail,
      this.startDate,
      this.endDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.statusName,
      this.shiftDetailName,
      this.positionName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    careHomeId = json['care_home_id'];
    position = json['position'];
    numberOfStaff = json['number_of_staff'];
    shiftDetail = json['shift_detail'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statusName = json['status_name'];
    shiftDetailName = json['shift_detail_name'];
    positionName = json['position_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['care_home_id'] = careHomeId;
    data['position'] = position;
    data['number_of_staff'] = numberOfStaff;
    data['shift_detail'] = shiftDetail;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status_name'] = statusName;
    data['shift_detail_name'] = shiftDetailName;
    data['position_name'] = positionName;
    return data;
  }
}
