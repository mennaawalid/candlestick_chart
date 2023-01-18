import 'package:flutter/cupertino.dart';

import '../authentication.dart';

class AuthProvider with ChangeNotifier {
  var _isAuthenticated = false;

  Future<void> setIsAuthenticated() async {
    _isAuthenticated = await Authenticate.authenticateUser();
    notifyListeners();
  }

  bool get getIsAuthenticated {
    return _isAuthenticated;
  }
}
