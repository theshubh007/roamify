
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Userdto.dart';

class Shpref_Service{

  static String _authkey = 'authstatus';
 static const String _userDtoKey = 'user_dto';

  static Future<void>  saveauthstatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_authkey, status);
  }

    static Future<bool> getauthstatus() async {
    final prefs = await SharedPreferences.getInstance();
        return  prefs.getBool(_authkey) ?? false;
  }


 static Future<void>  removeauthstatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authkey);
  }

  static Future<void> removealldata() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

   static Future<void> saveUserDto(Userdto userDto) async {
    final prefs = await SharedPreferences.getInstance();
    final userDtoJson = jsonEncode(userDto.toJson());
    await prefs.setString(_userDtoKey, userDtoJson);
  }

  static Future<Userdto?> getUserDto() async {
    final prefs = await SharedPreferences.getInstance();
    final userDtoJson = prefs.getString(_userDtoKey);
    if (userDtoJson != null) {
      final userDtoMap = jsonDecode(userDtoJson);
      return Userdto.fromJson(userDtoMap);
    }
    return null;
  }
}