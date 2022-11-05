import 'package:flutter/material.dart';
import 'package:reddit/Views/Screens/temphome.dart';
import 'package:username_gen/username_gen.dart';

import '../Widgets/choice_button.dart';
import '../Widgets/continue_username.dart';
import '../Widgets/sign_up_bar.dart';
import 'choose_profilepicture.dart';
import 'interests.dart';

class ChooseUserName extends StatefulWidget {
  const ChooseUserName({super.key});
  static const routeName = '/ChooseUserName';

  @override
  State<ChooseUserName> createState() => _ChooseUserNameState();
}

class _ChooseUserNameState extends State<ChooseUserName> {
  bool _submit = false;
  TextEditingController userNameController = TextEditingController();
  String? errorUserNameText;

  var _userNameSuggest = ['', '', ''];

  void submit1(userNameController, ctx) {
    print('sending data to back end');
    
    Navigator.of(ctx)
        .pushReplacementNamed(ChooseProfilePicture.routeName, arguments: {});
  }

  void submit2(String username, ctx) {
    print('sending data to back end');
    
    Navigator.of(ctx)
        .pushReplacementNamed(ChooseProfilePicture.routeName, arguments: {});
  }

  void refresh() {
    setState(() => _userNameSuggest = [
          UsernameGen().generate(),
          UsernameGen().generate(),
          UsernameGen().generate()
        ]);
  }

  @override
  void initState() {
    super.initState();
    _userNameSuggest = [
      UsernameGen().generate(),
      UsernameGen().generate(),
      UsernameGen().generate()
    ];
  }

  void validate(userNameController, ctx) {
    setState(() => _submit = true);
    if (_submit) {
      bool isValidUserName3 = true;

      errorUserNameText =
          !(isValidUserName3) ? 'That username is already taken' : null;

      if (isValidUserName3) {
        submit1(userNameController, ctx);
      } else {
        print("---" + userNameController.text + "---");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final dynamic appBar = buildAppBar();
    final heightScreen = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    final widthScreen = (mediaQuery.size.width);
    final padding = EdgeInsets.symmetric(
      vertical: heightScreen * 0.01,
      horizontal: widthScreen * 0.05,
    );
    final paddingleft = heightScreen * 0.03;
    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: paddingleft,
                      bottom: heightScreen * 0.01,
                    ),
                    child: const Text(
                      'Create your profile',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: padding,
                      child: const Text(
                        'Choose a username',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: paddingleft,
                      bottom: heightScreen * 0.01,
                    ),
                    child: const Text(
                      'Reddit is anonymous, so your username is what you\'ll go by here. Choose wisely-because once you get a name, you can\'t changeit.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: paddingleft,
                      bottom: heightScreen * 0.01,
                    ),
                    child: TextField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        errorText: errorUserNameText,
                        labelText: 'username',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      controller: userNameController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: paddingleft,
                      bottom: heightScreen * 0.01,
                    ),
                    child: const Text(
                      'This will be your name forever, so make sure it feels like you.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: paddingleft,
                      bottom: heightScreen * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Can\'t think of one? use one of these:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: refresh,
                          icon: const Icon(Icons.refresh_rounded),
                        ),
                      ],
                    ),
                  ),
                  chooseUserName(
                      paddingleft, heightScreen, context, _userNameSuggest[0]),
                  chooseUserName(
                      paddingleft, heightScreen, context, _userNameSuggest[1]),
                  chooseUserName(
                      paddingleft, heightScreen, context, _userNameSuggest[2]),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: heightScreen * 0.02),
                child: ContinueUserName(
                  userNameController: userNameController,
                  function: validate,
                  ctx: context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding chooseUserName(
    double paddingleft,
    double heightScreen,
    BuildContext context,
    String username,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: paddingleft,
        bottom: heightScreen * 0.01,
      ),
      child: ChoiceButton(username, submit2, context),
    );
  }
}
