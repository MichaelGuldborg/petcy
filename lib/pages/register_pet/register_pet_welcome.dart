import 'package:flutter/material.dart';
import 'package:petcy/components/rounded_button.dart';
import 'package:petcy/pages/register_pet/register_pet_page.dart';

class RegisterPetWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Tell us a bit about your furry friends so we can tailor the perfect diet for their needs.'
                'This process should take about 2-3 minutes to complete.\n'
                'Focus on one pet now and create an additional pet profile later.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 40),
              RoundedButton(
                text: "Cool, let's go!",
                onPressed: () {
                  RegisterPetPageState.of(context).onNextPressed();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
