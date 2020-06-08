import 'package:flutter/material.dart';
import 'package:sign_in_app/src/pages/login_page.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign in methods',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' : ( BuildContext context ) => LoginPage()
      },
      theme: ThemeData(
            primaryColor: Colors.black
      ),
    );
  }
}