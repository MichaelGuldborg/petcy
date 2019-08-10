import 'package:flutter/material.dart';
import 'package:petcy/pages/register_pet/sign_up_page.dart';
import 'package:petcy/theme.dart';

void main() => runApp(App());

// TODO WRAP IN STATE PROVIDER
// BLOC ? INHERITED WIDGET ?
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => SignUpPage(),
      },
    );
  }
}
