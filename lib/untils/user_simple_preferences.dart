import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;
  static const String isUserLoggedIn = 'isuserloggedin';
  static const String isToken = 'token';

  static const String userDataLocal = 'userData';
  static const String isRefreshToken = 'refresh_token';
  static const String isFingerprint = 'true';
  static const String fcmToken = 'fcmToken';
  static const String uniquecode = 'uniquecode';
  static const String userDetails = 'userDetails';

  ///
  static const String isUserId = 'userId';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setLoginStatus({required bool loginStatus}) async {
    await _preferences.setBool(isUserLoggedIn, loginStatus);
  }

  static bool? getLoginStatus() {
    return _preferences.getBool(isUserLoggedIn);
  }

  static Future setfcmToken(String? token) async {
    await _preferences.setString(fcmToken, token!);
  }

  static String? getfcmToken() {
    return (_preferences.getString(fcmToken));
  }

  static Future setuniquecode(String? identifier) async {
    await _preferences.setString(uniquecode, identifier!);
  }

  static String? getuniquecode() {
    return (_preferences.getString(uniquecode));
  }

  static Future setUserdata({required String userData}) async {
    await _preferences.setString(userDataLocal, userData);
  }

  static String? getUserdata() {
    return (_preferences.getString(userDataLocal));
  }

  static Future setfingerprintdata({required String userData}) async {
    await _preferences.setString(isFingerprint, userData);
  }

  static Future setRefreshToken({required String refreshToken}) async {
    await _preferences.setString(isRefreshToken, refreshToken);
  }

  static String? getRefreshToken() {
    return _preferences.getString(isRefreshToken);
  }

  static String? getfingerprintdata() {
    return (_preferences.getString(isFingerprint));
  }

  static Future setToken({required String token}) async {
    await _preferences.setString(isToken, token);
  }

  static String? getToken() {
    return _preferences.getString(isToken);
  }

  /////
  static Future setUserid({required String userId}) async {
    await _preferences.setString(isUserId, userId);
  }

  static String? getUserid() {
    return _preferences.getString(isUserId);
  }

  // Set userDetails
  static Future setUserDetails(Map userDetailsMap) async {
    String userDetailsJson = jsonEncode(userDetailsMap);
    await _preferences.setString(userDetails, userDetailsJson);
  }

  // Get userDetails
  static Map? getUserDetails() {
    String? userDetailsJson = _preferences.getString(userDetails);
    if (userDetailsJson != null) {
      return jsonDecode(userDetailsJson);
    }
    return null;
  }

  static void clearAllData() {
    _preferences.clear();
  }
}
