import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys{
  SharedPrefKeys._();

  static const String languageKey = 'languageCode';
  static const String loginKey = 'loginCode';
  static const String userKey = 'userCode';
}

class SharedPreferenceService {

  static SharedPreferenceService _instance;
  static SharedPreferences _preferences;

  SharedPreferenceService._internal();

  static Future<SharedPreferenceService> get instance async {
    if (_instance == null){
      _instance = SharedPreferenceService._internal();
    }

    if (_preferences == null){
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  Future<void> setLanguageCode(String languageCode) async => 
    await _preferences.setString(SharedPrefKeys.languageKey, languageCode);

  String get languageCode => _preferences.getString(SharedPrefKeys.languageKey);


  Future<void> setLoginCode(bool code) async => 
    await _preferences.setBool(SharedPrefKeys.loginKey, code);

  bool get isLogin => _preferences.getBool(SharedPrefKeys.loginKey);

  Future<void> setUserData(String userCode) async => 
    await _preferences.setString(SharedPrefKeys.userKey, userCode);

  String get userData => _preferences.getString(SharedPrefKeys.userKey);
  
}