import 'package:flutter/material.dart';
import 'package:petcy/pages/auth/splash_page.dart';
import 'package:petcy/pages/register_pet/register_pet_page.dart';
import 'package:petcy/theme.dart';

void main() => runApp(App());

// TODO WRAP IN STATE PROVIDER
// BLOC ? INHERITED WIDGET ?
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/register_pet': (context) => RegisterPetPage(),
      },
    );
  }
}
