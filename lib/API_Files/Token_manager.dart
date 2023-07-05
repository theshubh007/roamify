import 'package:shared_preferences/shared_preferences.dart';

// class TokenManager {
//   static const String _tokenKey = 'jwt_token';
//   static const String _tokenidKey = 'jwt_token_id';
//   static String cachedkey = "";
//   static Future<void> init() async {
//     cachedkey = await getToken();
//   }

//   static Future<void> saveTokenandid(String token, String tokenid) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_tokenKey, token);
//     await prefs.setString(_tokenidKey, tokenid);

//     cachedkey = tokenid;
//   }

//   static Future<void> saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_tokenKey, token);
//   }

//   static Future<String> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_tokenKey) ?? '';
//   }

//   static Future<String> getTokenid() async {
//     final prefs = await SharedPreferences.getInstance();
//     return await prefs.getString(_tokenidKey) ?? '';
//   }

//   static Future<void> removeToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_tokenKey);
//   }
// }

class TokenManager {
  static const String _tokenKey = 'jwt_token';
  static const String _tokenidKey = 'jwt_token_id';

  static SharedPreferences? _prefs; // SharedPreferences instance

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveTokenandid(String token, String tokenid) async {
    await _prefs?.setString(_tokenKey, token);
    await _prefs?.setString(_tokenidKey, tokenid);
  }

  static Future<void> saveToken(String token) async {
    await _prefs?.setString(_tokenKey, token);
  }

  static Future<String> getToken() async {
    return _prefs?.getString(_tokenKey) ?? '';
  }

  static Future<String> getTokenid() async {
    return _prefs?.getString(_tokenidKey) ?? '';
  }

  static Future<void> removeToken() async {
    await _prefs?.remove(_tokenKey);
    await _prefs?.remove(_tokenidKey);
  }
}

