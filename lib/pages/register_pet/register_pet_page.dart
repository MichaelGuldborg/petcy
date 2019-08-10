import 'package:flutter/material.dart';
import 'package:petcy/app_colors.dart';
import 'package:petcy/components/progress_bar.dart';
import 'package:petcy/models/pet.dart';
import 'package:petcy/pages/register_pet/age_question_page.dart';
import 'package:petcy/pages/register_pet/index_question_page.dart';
import 'package:petcy/pages/register_pet/json_page.dart';
import 'package:petcy/pages/register_pet/register_pet_success.dart';
import 'package:petcy/pages/register_pet/register_pet_welcome.dart';

class _RegisterPetPageStateProvider extends InheritedWidget {
  final RegisterPetPageState state;

  _RegisterPetPageStateProvider({this.state, child}) : super(child: child);

  @override
  bool updateShouldNotify(_RegisterPetPageStateProvider old) => false;
}

class RegisterPetPage extends StatefulWidget {
  RegisterPetPageState createState() => RegisterPetPageState();
}

class RegisterPetPageState extends State<RegisterPetPage> {
  static RegisterPetPageState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_RegisterPetPageStateProvider)
            as _RegisterPetPageStateProvider)
        .state;
  }

  final pageController = PageController();
  final Pet pet = Pet();
  int viewIndex = 0;

  final duration = const Duration(milliseconds: 400);
  final curve = Curves.fastOutSlowIn;

  Future<bool> onNextPressed() async {
    pageController.nextPage(duration: duration, curve: curve);
    setState(() {
      viewIndex = pageController.page.round() + 1;
    });
    return false;
  }

  Future<bool> onBackPress() async {
    if (viewIndex == 0) {
      return true;
    }

    pageController.previousPage(duration: duration, curve: curve);
    setState(() {
      viewIndex = pageController.page.round() - 1;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final title = Text(
      'Petcy',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.w500,
      ),
    );

    return _RegisterPetPageStateProvider(
      state: this,
      child: WillPopScope(
        onWillPop: onBackPress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.primary, AppColors.accent],
            ),
          ),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: title,
                    centerTitle: true,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.close,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: ProgressBar(
                max: 6,
                index: viewIndex,
              ),
              body: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Builder(
                    builder: (context) => RegisterPetWelcome(),
                  ),
                  Builder(
                    builder: (context) => IndexQuestionPage(
                      index: 1,
                      question: "What type of pet do you have?",
                      answers: ["dog", "cat"],
                      icons: [
                        Icons.font_download,
                        Icons.format_bold,
                      ],
                      onAnswer: (String answer) {
                        RegisterPetPageState.of(context).pet.animal = answer;
                        onNextPressed();
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) => IndexQuestionPage(
                      index: 2,
                      question:
                          "Is your ${RegisterPetPageState.of(context).pet.animal} a male or female?",
                      answers: ["male", "female"],
                      onAnswer: (String answer) {
                        RegisterPetPageState.of(context).pet.sex = answer;
                        onNextPressed();
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) => AgeQuestionPage(
                      index: 3,
                      question:
                          "How old is ${RegisterPetPageState.of(context).pet.sex == 'male' ? "he" : "she"}?",
                      onAnswer: (int months) {
                        RegisterPetPageState.of(context).pet.months = months;
                        print("Pet: ${RegisterPetPageState.of(context).pet.toJson()}");
                        onNextPressed();
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) => IndexQuestionPage(
                      index: 4,
                      question:
                          "How would you describe ${RegisterPetPageState.of(context).pet.sex == 'male' ? "his" : "her"} body condition?",
                      answers: [
                        "Skinny McBony",
                        "A bit underweight",
                        "Just about ideal",
                        "Undercover chubber",
                        "Obesepotamus",
                      ],
                      onAnswer: (String answer) {
                        RegisterPetPageState.of(context).pet.weight = answer;
                        print("Pet: ${RegisterPetPageState.of(context).pet.toJson()}");
                        onNextPressed();
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) => RegisterPetSuccess(),
                  ),
                  Builder(
                    builder: (context) => JsonPage(
                      json: RegisterPetPageState.of(context).pet.toJson(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
