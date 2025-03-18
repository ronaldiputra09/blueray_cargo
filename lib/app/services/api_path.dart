// ignore_for_file: constant_identifier_names

class ApiPath {
  static const BASE_URL = "https://devuat.blueraycargo.id/api/blueray";

  // REGISTER
  static const REGISTER = "$BASE_URL/customer/register/mini";
  static const VERIFY_CODE = "$BASE_URL/customer/register/verify-code";
  static const MANDATORY = "$BASE_URL/customer/register/mandatory";
  static const RESEND_CODE = "$BASE_URL/customer/register/resend-code";

  // LOGIN
  static const LOGIN = "$BASE_URL/customer/login";
  static const LOGOUT = "$BASE_URL/customer/logout";

  // UPLOAD
  static const UPLOAD_IMAGE = "$BASE_URL/image/upload";
  static const UPLOAD_FILE = "$BASE_URL/file/upload";

  // LOKASI
  static const LOKASI = "$BASE_URL/address/subdistricts/search";

  // ALAMAT
  static const ADDRESS = "$BASE_URL/customer/address";
  static const DELETE_ADDRESS = "$BASE_URL/customer/address/delete";

  // PRIMARY SET
  static const PRIMARY_SET = "$BASE_URL/customer/address/primary";
}
