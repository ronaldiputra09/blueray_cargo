class AlamatModel {
  int? addressId;
  int? provinceId;
  String? provinceName;
  int? districtId;
  String? districtName;
  int? subDistrictId;
  String? subDistrictName;
  String? cityCode;
  String? npwpFile;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? service;
  String? addressType;
  String? addressLabel;
  String? name;
  String? countryName;
  String? address;
  String? postalCode;
  double? long;
  double? lat;
  String? addressMap;
  String? email;
  String? phoneNumber;
  String? phoneNumber2;
  String? npwp;
  bool? isPrimary;
  String? note;
  int? customer;
  int? province;
  int? district;
  int? subDistrict;
  int? country;

  AlamatModel(
      {this.addressId,
      this.provinceId,
      this.provinceName,
      this.districtId,
      this.districtName,
      this.subDistrictId,
      this.subDistrictName,
      this.cityCode,
      this.npwpFile,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.service,
      this.addressType,
      this.addressLabel,
      this.name,
      this.countryName,
      this.address,
      this.postalCode,
      this.long,
      this.lat,
      this.addressMap,
      this.email,
      this.phoneNumber,
      this.phoneNumber2,
      this.npwp,
      this.isPrimary,
      this.note,
      this.customer,
      this.province,
      this.district,
      this.subDistrict,
      this.country});

  AlamatModel.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    subDistrictId = json['sub_district_id'];
    subDistrictName = json['sub_district_name'];
    cityCode = json['city_code'];
    npwpFile = json['npwp_file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    service = json['service'];
    addressType = json['address_type'];
    addressLabel = json['address_label'];
    name = json['name'];
    countryName = json['country_name'];
    address = json['address'];
    postalCode = json['postal_code'];
    long = json['long'];
    lat = json['lat'];
    addressMap = json['address_map'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    phoneNumber2 = json['phone_number_2'];
    npwp = json['npwp'];
    isPrimary = json['is_primary'];
    note = json['note'];
    customer = json['customer'];
    province = json['province'];
    district = json['district'];
    subDistrict = json['sub_district'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['province_id'] = provinceId;
    data['province_name'] = provinceName;
    data['district_id'] = districtId;
    data['district_name'] = districtName;
    data['sub_district_id'] = subDistrictId;
    data['sub_district_name'] = subDistrictName;
    data['city_code'] = cityCode;
    data['npwp_file'] = npwpFile;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['service'] = service;
    data['address_type'] = addressType;
    data['address_label'] = addressLabel;
    data['name'] = name;
    data['country_name'] = countryName;
    data['address'] = address;
    data['postal_code'] = postalCode;
    data['long'] = long;
    data['lat'] = lat;
    data['address_map'] = addressMap;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['phone_number_2'] = phoneNumber2;
    data['npwp'] = npwp;
    data['is_primary'] = isPrimary;
    data['note'] = note;
    data['customer'] = customer;
    data['province'] = province;
    data['district'] = district;
    data['sub_district'] = subDistrict;
    data['country'] = country;
    return data;
  }

  static List<AlamatModel> fromJsonList(List list) {
    return list.map((item) => AlamatModel.fromJson(item)).toList();
  }
}
