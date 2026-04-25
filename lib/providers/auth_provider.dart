// providers/auth_provider.dart (Updated)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userName;
  String? _userEmail;
  String? _profileImageUrl;

  bool get isLoggedIn => _isLoggedIn;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get profileImageUrl => _profileImageUrl;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userName = prefs.getString('userName');
    _userEmail = prefs.getString('userEmail');
    _profileImageUrl = prefs.getString('profileImageUrl');
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (email.isNotEmpty && password.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      _isLoggedIn = true;
      _userEmail = email;
      _userName = email.split('@')[0];
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', email);
      await prefs.setString('userName', _userName!);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password, {String? profileImageUrl}) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      _isLoggedIn = true;
      _userName = name;
      _userEmail = email;
      _profileImageUrl = profileImageUrl;
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', name);
      await prefs.setString('userEmail', email);
      if (profileImageUrl != null) {
        await prefs.setString('profileImageUrl', profileImageUrl);
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> updateProfile({String? name, String? email, String? profileImageUrl}) async {
    final prefs = await SharedPreferences.getInstance();
    if (name != null) {
      _userName = name;
      await prefs.setString('userName', name);
    }
    if (email != null) {
      _userEmail = email;
      await prefs.setString('userEmail', email);
    }
    if (profileImageUrl != null) {
      _profileImageUrl = profileImageUrl;
      await prefs.setString('profileImageUrl', profileImageUrl);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = false;
    _userName = null;
    _userEmail = null;
    _profileImageUrl = null;
    await prefs.clear();
    notifyListeners();
  }
}