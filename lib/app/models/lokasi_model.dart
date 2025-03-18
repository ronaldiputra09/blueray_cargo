class LokasiModel {
  String? address;
  String? province;
  String? district;
  String? subDistrict;
  String? subDistrictCode;
  int? provinceId;
  int? districtId;
  int? subDistrictId;

  LokasiModel(
      {this.address,
      this.province,
      this.district,
      this.subDistrict,
      this.subDistrictCode,
      this.provinceId,
      this.districtId,
      this.subDistrictId});

  LokasiModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    province = json['province'];
    district = json['district'];
    subDistrict = json['sub_district'];
    subDistrictCode = json['sub_district_code'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    subDistrictId = json['sub_district_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['province'] = province;
    data['district'] = district;
    data['sub_district'] = subDistrict;
    data['sub_district_code'] = subDistrictCode;
    data['province_id'] = provinceId;
    data['district_id'] = districtId;
    data['sub_district_id'] = subDistrictId;
    return data;
  }

  static List<LokasiModel> fromJsonList(List list) {
    return list.map((item) => LokasiModel.fromJson(item)).toList();
  }
}
