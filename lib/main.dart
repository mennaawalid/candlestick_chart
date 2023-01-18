import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/authentication_screen.dart';
import '../providers/authentication_peovider.dart';
import '../providers/chart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<ChartProvider>(
          create: (context) => ChartProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const AuthenticationScreen(),
      ),
    );
  }
}
