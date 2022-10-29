import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/email_me_button.dart';
import '../Widgets/sign_up_bar.dart';
import '../Widgets/uesrname_password_textfield.dart';
import 'email_login.dart';

class ForgetUserName extends StatefulWidget {
  const ForgetUserName({super.key});
  static const routeName = '/ForgetUserName';

  @override
  State<ForgetUserName> createState() => _ForgetUserNameState();
}

class _ForgetUserNameState extends State<ForgetUserName> {
  TextEditingController emailController = TextEditingController();

  void submit(emailController, ctx) {
    print('sending data to back end');
    Navigator.of(ctx).pop();
  }

  void havingTrouble(havingTroubleurl) {
    launchUrl(havingTroubleurl);
  }

  void emailLogin(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed(EmailLogin.routeName, arguments: {});
  }

  @override
  Widget build(BuildContext context) {
    final havingTroubleurl =
        Uri.parse('https://www.reddithelp.com/hc/en-us/articles/205240005');
    final mediaQuery = MediaQuery.of(context);
    final dynamic appBar =
        buildAppBar(text: 'Log in', function: () => emailLogin(context));
    final heightScreen = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top);
    final padding = EdgeInsets.symmetric(
      vertical: heightScreen * 0.01,
      horizontal: mediaQuery.size.width * 0.1,
    );
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
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: padding,
                      child: const Text(
                        'Recover username',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightScreen * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      heightScreen * 0.02,
                    ),
                    child: EmailText(emailController: emailController),
                  ),
                  SizedBox(
                    height: heightScreen * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      heightScreen * 0.02,
                    ),
                    child: const Text(
                      'Unfortunately,if you have never given us you email, we will not be able to reset your password.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      heightScreen * 0.02,
                    ),
                    child: textbutton('Having trouble?',
                        () => havingTrouble(havingTroubleurl)),
                  ),
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
                child: MailMeButton2(
                  emailController: emailController,
                  function: submit,
                  ctx: context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextButton textbutton(txt, fuction) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor:
            MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
      ),
      onPressed: fuction,
      child: Text(
        txt,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
