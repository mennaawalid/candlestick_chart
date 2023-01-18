import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/authentication_peovider.dart';
import 'finances_chart_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Center(
              child: Text(
            'Login',
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.bold,
            ),
          )),
          Container(
            margin: EdgeInsets.symmetric(vertical: size.height * 0.1),
            child: Column(
              children: [
                Icon(
                  Icons.fingerprint,
                  size: size.width * 0.3,
                  color: Theme.of(context).primaryColor,
                ),
                const Text(
                  'Fingerprint Authentication',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.025),
                  child: const FittedBox(
                    child: Text(
                      'Authenticate using fingerprint instead of password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await authProvider.setIsAuthenticated();
                      if (authProvider.getIsAuthenticated) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FinacesChartScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Authentication failed.'),
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(15),
                    ),
                    child: const Text('Authenticate'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
