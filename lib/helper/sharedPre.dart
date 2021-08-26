import 'package:shared_preferences/shared_preferences.dart';

class SharedPre {
  static final String _userEmail = '_id';

  static Future<void> setUserEmail(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userEmail, val);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmail) ?? "";
  }
}
