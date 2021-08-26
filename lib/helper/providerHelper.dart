import 'package:flutter/material.dart';

class ProviderHelper extends ChangeNotifier {
  bool hasLoggedIn = false;
  late String email;
  late String name;

  void setHasLoggedIn(bool x) {
    hasLoggedIn = x;
    notifyListeners();
  }

  String imageUrl = "";
}
