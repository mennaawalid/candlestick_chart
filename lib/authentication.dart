import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Authenticate {
  static Future<bool> authenticateUser() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isAuthenticated = false;

    bool isBiometricSupported = await localAuthentication.isDeviceSupported();

    if (isBiometricSupported) {
      try {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason: 'scan your fingerprint to authenticate',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      } on PlatformException catch (e) {
        print(e);
      }
    }
    return isAuthenticated;
  }
}
